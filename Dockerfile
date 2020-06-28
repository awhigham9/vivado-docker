FROM ubuntu:14.04

LABEL maintainer="Andrew Whigham <awhigham9@gmail.com>"
LABEL description="A Dockerfile to build an Ubuntu 14.04 image with Xilinx Vivado 2015.4 installed"
# build with docker build --build-arg VIVADO_TAR_HOST=host:port --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2016.3_1011_1 -t vivado .

#install dependences for:
# * xsim (gcc build-essential to also get make)
# * MIG tool (libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig)
# * CI (git)
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y  libglib2.0-0 
RUN apt-get install -y  libsm6 
RUN apt-get install -y  libxi6 
RUN apt-get install -y  libxrender1 
RUN apt-get install -y  libxrandr2 
RUN apt-get install -y  libfreetype6 
RUN apt-get install -y  libfontconfig 
RUN apt-get install -y  git 
RUN apt-get install -y  libxtst6
# 32-bit libraries
RUN dpkg --add-architecture i386
RUN apt-get install -y  lib32bz2-1.0
RUN apt-get install -y lib32z1 
RUN apt-get install -y lib32ncurses5
RUN apt-get clean

# copy in config file
COPY install_config.txt /

# download and run the install
ARG VIVADO_TAR_FILE
ARG VIVADO_VERSION
RUN echo "Adding ${VIVADO_TAR_FILE}.tar.gz"
ADD ${VIVADO_TAR_FILE}.tar.gz /
RUN /${VIVADO_TAR_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_config.txt && \
  rm -rf ${VIVADO_TAR_FILE}*
#make a Vivado user
#RUN adduser --disabled-password --gecos '' vivado
#USER vivado
#WORKDIR /home/vivado
#add vivado tools to path
USER root
RUN echo "source /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> ~root/.bashrc

#copy in the license file
COPY Xilinx.lic /root/.Xilinx/
