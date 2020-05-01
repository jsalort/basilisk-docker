# basilisk-docker

This package creates a Docker implementation of basilisk. Dockerfiles to build the container and a shell script to run it are provided.
The difference compared to the original dockerfile [provided by sgllewellynsmith](https://github.com/sgllewellynsmith/basilisk-docker) are that
I don't install GUI applications in the docker container (such as gv, evince, etc.), and this docker file is based on my base docker file
which has Python 3.8 Anaconda and TeXLive 2020. If you don't need those, and wish to use GUI apps, use sgllewellynsmith version instead.

# Installation and Usage

No particular compilation is required since this docker file is published on [DockerHub](https://hub.docker.com/repository/docker/jsalort/basilisk).
To use it, simply source the `docker_alias.sh` file, e.g.

```bash
$ source docker_alias.sh
```

This will create shortcuts to the docker programs, such as `qcc`.

The generated programs may have to be executed in the docker environment, so the `run_program` bash function is provided for
conveniance, i.e. for the `bump` program from the [tutorial](http://basilisk.fr/Tutorial), after sourcing `docker_alias.sh`, one
can do

```bash
$ qcc -O2 -Wall bump.c -o bump -lm
$ run_program "./bump > out.ppm 2> log"
```
