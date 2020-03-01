#!/bin/sh

. scripts/env.sh

./scripts/clean-openssl.sh
./scripts/clean-openresty.sh

rm -rf "$PROXY_OPENSSL_SOURCE_PATH"
rm -rf "$PROXY_OPENRESTY_SOURCE_PATH"
