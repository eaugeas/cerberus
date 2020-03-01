#!/bin/sh

. scripts/env.sh

if [ ! -x "$PROXY_OPENRESTY_INSTALL_PATH"/bin/openresty ]; then
    echo "$PROXY_OPENRESTY_INSTALL_PATH/bin/openresty not found. The project"
    echo "may need to be build with make"
    exit 1
fi

NGINX_PID=$(ps aux | grep "master process" | grep -v grep | awk "{ print $2 }")
if [ -z "$NGINX_PID" ]; then
    # run openresty if it is not running
    "$PROXY_OPENRESTY_INSTALL_PATH"/bin/openresty -c conf/nginx_spectest.conf
fi

go test -v ./...

"$PROXY_OPENRESTY_INSTALL_PATH"/bin/openresty -s quit
