#!/bin/sh

. scripts/env.sh

if [ -f "$PROXY_OPENRESTY_SOURCE_PATH/Makefile" ]; then
    make -C "$PROXY_OPENRESTY_SOURCE_PATH" clean
fi

rm -rf "$PROXY_OPENRESTY_INSTALL_PATH"
