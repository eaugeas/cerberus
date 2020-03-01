#!/bin/sh

. scripts/env.sh

if [ -f "$PROXY_OPENSSL_SOURCE_PATH/Makefile" ]; then
    make -C "$PROXY_OPENSSL_SOURCE_PATH"make clean
    make -C "$PROXY_OPENSSL_SOURCE_PATH" distclean
fi
