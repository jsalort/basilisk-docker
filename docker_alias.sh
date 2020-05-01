# Python
ipython() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest ipython $@
}
python() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest python $@
}
jupyterlab() {
	docker run -it --rm --name jupyterlab --cap-add=SYS_ADMIN -p 8888:8888 -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest jupyter lab --ip=0.0.0.0 --port 8888 $@
}
pre-commit() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest pre-commit $@
}
git() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -v ${HOME}/.gitconfig:/home/liveuser/.gitconfig -w /home/liveuser/workdir jsalort/basilisk:latest git $@
}

# Texlive
pdflatex() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest pdflatex $@
}
lualatex() {
	docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest lualatex $@
}

# Basilisk
qcc() {
    docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest qcc $@
}

# If there are redirections, use quotes, i.e.
# run_program "./bump > out.ppm"
run_program() {
    docker run -it --rm -v ${PWD}:/home/liveuser/workdir -w /home/liveuser/workdir jsalort/basilisk:latest bash -c "$@"
}
