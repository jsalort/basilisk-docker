FROM jsalort/py38:latest
LABEL maintainer "Julien Salort <julien.salort@ens-lyon.fr>"

# We use our base environment with Anaconda Python and Texlive,
# but the compilers from the base system
# so we unset Anaconda's environment variables
ENV CC "/usr/bin/gcc"
ENV CXX "/usr/bin/g++"
ENV AR "/usr/bin/ar"
ENV RANLIB "/usr/bin/ranlib"
ENV CPP "/usr/bin/cpp"
ENV FC "/usr/bin/gfortran"

# basic tools (gawk is needed to avoid a debian clash; apt-utils is useful)
USER root
RUN apt-get -y update && apt-get install -y \
    darcs flex make gawk apt-utils
USER liveuser

#get basilisk
WORKDIR /home/liveuser
RUN darcs get --lazy http://basilisk.fr/basilisk
ENV BASILISK /home/liveuser/basilisk/src
ENV PATH $PATH:/home/liveuser/basilisk/src

# Packages
USER root
# useful additional packages (basilisk)
RUN apt-get -y update && apt-get install -y \
    gnuplot imagemagick ffmpeg smpeg-plaympeg graphviz valgrind gifsicle
# Using Basilisk with python
RUN apt-get -y update && apt-get install -y swig
# You also need to setup the MDFLAGS and PYTHONINCLUDE variables in your config file.
# ssh is needed for certain tests
RUN apt-get -y update && apt-get install -y openssh-server
# is this needed?
RUN mkdir /var/run/sshd
# libgsl-dev is needed for certain tests
RUN apt-get -y update && apt-get install -y libgsl-dev
# unzip is needed for topographic databases
RUN apt-get -y update && apt-get install -y unzip 
# mpi
RUN apt-get -y update && apt-get install -y \
    libopenmpi-dev openmpi-bin
# python graphics
USER liveuser
RUN source /home/liveuser/.bashrc && \
    conda activate py38 && \
    conda install -q -y expat && \
    python -m pip install gprof2dot xdot
# gerris
USER root
RUN apt-get -y update && apt-get install -y \
    gerris gfsview-batch

# CADNA
# need wget
USER root
RUN apt-get -y update && apt-get install wget

USER liveuser
RUN wget http://cadna.lip6.fr/Download_Dir/cadna_c-2.0.2.tar.gz; \
    tar xzvf cadna_c-2.0.2.tar.gz; \ 
    cd cadna_c-2.0.2/; \
    patch -p1 < $BASILISK/cadna.patch; \
    ./configure; \
    make
USER root
RUN cd cadna_c-2.0.2/; \
    make install
RUN apt-get -y update && apt-get install -y clang
USER liveuser

# install Vof (gfortran is used for tests; not needed here for installation)
USER root
RUN apt-get -y update && apt-get install -y gfortran
USER liveuser
RUN wget http://www.ida.upmc.fr/~zaleski/paris/Vofi-1.0.tar.gz; \
    tar xzvf Vofi-1.0.tar.gz
RUN cd Vofi; \
    ./configure; \
    make lib
USER root
RUN cd Vofi; \
    make install
USER liveuser

# make basilisk
RUN cd $BASILISK; \
    ln -s config.gcc config; \
    make

USER root
# off-screen rendering
RUN apt-get -y update && apt-get install -y \
    libglu1-mesa-dev libosmesa6-dev bison
# graphics-acceleration hardware
RUN apt-get -y update && apt-get install -y \
    libglu1-mesa-dev libglew-dev libgl1-mesa-dev
USER liveuser

# off-screen rendering
RUN cd $BASILISK/gl; \
    make libglutils.a libfb_osmesa.a
# graphics-acceleration hardware
RUN cd $BASILISK/gl; \
    make libfb_glx.a

# # bview servers off-screen rendering
# #ENV OPENGLIBS = -lfb_osmesa -lGLU -lOSMesa
# # bview servers graphics-acceleration hardware
# ENV OPENGLIBS = -lfb_glx -lGLU -lGLEW -lGL -lX11
# RUN cd $BASILISK; \
#     make bview-servers
# 
# USER root
# # other useful packages (SGLS)
# # non-graphical (gfortran used in Vofi tests)
# RUN apt-get -y update && apt-get install -y \
#      less emacs pstoedit
# # graphical
# RUN apt-get -y update && apt-get install -y \
#     vlc xpdf gimp xterm nomacs evince meshlab gv
# USER liveuser
# 
# CMD /bin/bash
