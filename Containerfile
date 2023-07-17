FROM docker.io/debian:11.3
LABEL authors="Kosmas Hench" \
      description="Container for mutation load analysis tools"

# setting up conda
RUN apt update && apt install -y wget procps
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p /miniconda

ENV PATH ${PATH}:/miniconda/bin

# install mamba for fast installation and set up channels
RUN conda install mamba=1.4.9 -y -n base -c conda-forge
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge

# install packages available via conda
COPY env.yml /
RUN mamba env create -f env.yml && conda clean -a

# set up JAVA_HOME
ENV JAVA_HOME /miniconda/envs/re_load-0.1/lib/jvm/
RUN export JAVA_HOME

# install rohmm manually
RUN apt install -y git
RUN mkdir -p /manual_install/bin && \
    cd /manual_install && \
    git clone https://github.com/kelepiradam/ROHMMCLI.git && \
    cd ROHMMCLI && \
   ./build.sh && \
   echo -e '#!/usr/bin/env bash'"\njava -jar `pwd`/target/ROHMM-Java8-Full-Jar/ROHMMCLI-1.0.4b-GUI.jar "'${1}' > rohmm && \
   chmod 755 rohmm && \
   cd ../bin && \
   ln ../ROHMMCLI/rohmm ./

ENV PATH ${PATH}:/miniconda/envs/re_load-0.1/bin:/manual_install/bin