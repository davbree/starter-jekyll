#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://simon-stackbit.ngrok.io/project/5f3160a8b6643a78ad873bec/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://simon-stackbit.ngrok.io/pull/5f3160a8b6643a78ad873bec
fi
curl -s -X POST https://simon-stackbit.ngrok.io/project/5f3160a8b6643a78ad873bec/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://simon-stackbit.ngrok.io/project/5f3160a8b6643a78ad873bec/webhook/build/publish > /dev/null
