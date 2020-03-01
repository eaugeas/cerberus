#!/bin/sh

. scripts/env.sh

if [ ! -d "$PROXY_OPENRESTY_SOURCE_PATH" ]; then
    tar xvf "$PROXY_OPENRESTY_TAR_GZ_PATH" -C "$PROXY_DEPS_PATH/"
fi
if [ ! -d "$PROXY_OPENSSL_SOURCE_PATH" ]; then
    tar xvf "$PROXY_OPENSSL_TAR_GZ_PATH" -C "$PROXY_DEPS_PATH/"
fi

cd "$PROXY_OPENRESTY_SOURCE_PATH" || exit 1
./configure --with-openssl="$PROXY_OPENSSL_SOURCE_PATH" \
            --prefix="$PROXY_OPENRESTY_INSTALL_PATH"

make
make install

cd "$PROXY_BASE_PATH" || exit 1
cp -r "$PROXY_SOURCE_PATH"/oasis "$PROXY_OPENRESTY_INSTALL_PATH/lualib/"
cp -r "$PROXY_CONF_PATH"/* "$PROXY_OPENRESTY_INSTALL_PATH/nginx/conf"
