# Cerberus
The cerberus repository is intended to maintain a build of [openresty](https://openresty.org/en/). A docker image is created from this repository that can be used in other projects to add lua code that can be used in the nginx configuration files

## Setup
In order to be able to compile the project, in Ubuntu 18.04 make sure that your system has the following dependencies:
```sh
$ apt install build-essential libpcre3 libpcre3-dev lua5.2 golang-go
```

If you would like to also build a docker image of the project, docker must be in the system
```sh
$ apt install docker
```

## Build
The build process builds the version of openssl attached as a dependency along with the openresty project. In order to run the compilation step you can run in the command line

```sh
$ make
```

## Tests
In order to run the unittests of the lua scripts that run on the nginx engine

```sh
$ make unittests
```

To run the integration tests written in Go against a build running locally

```sh
$ make tests-local
```

## Howto
After following the steps in the Build section, you should have a `build/` folder where openresty has been built. In order to run openresty with the standard configuration

```sh
$ build/bin/openresty -c conf/nginx.conf
```

In order to quit openresty
```sh
$ build/bin/openresty -s quit
```

Feel free to look at the help provided by openresty to find out more about the commands provided
```sh
$ build/bin/openresty -h

nginx version: openresty/1.15.8.1
Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /home/eauge/Workspace/src/github.com/tlblanc/cerberus/build/nginx/)
  -c filename   : set configuration file (default: conf/nginx.conf)
  -g directives : set global directives out of configuration file
```
