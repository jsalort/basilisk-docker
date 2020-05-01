SHELL := /bin/bash

all: out.mp4 log.pdf

bump: bump.c
	source ../docker_alias.sh && qcc -O2 -Wall bump.c -o bump -lm

out.ppm: bump
	source ../docker_alias.sh && run_program "./bump > out.ppm 2> log"

out.mp4: out.ppm
	ffmpeg -i out.ppm -an -vcodec libx264 -crf 23 out.mp4

log.pdf: out.ppm
	source ../docker_alias.sh && python plot_log.py

clean:
	rm -f log log.pdf out.mp4 out.ppm