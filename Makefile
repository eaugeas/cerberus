all: build-openresty

build-openresty:
	./scripts/build-openresty.sh

build-docker:
	./scripts/build-docker.sh

clean:
	./scripts/clean-openresty.sh
	./scripts/clean-openssl.sh

unittests: src/oasis/auth/passauth_test.lua
	cd src && lua oasis/auth/passauth_test.lua

tests-local:
	./scripts/tests-local.sh

distclean:
	./scripts/distclean.sh
