# basilisk-docker

This package creates a Docker implementation of basilisk. Dockerfiles to build the container and a shell script to run it are provided.

# Usage

Simply source the `docker_alias.sh` file, e.g.

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
