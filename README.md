
# vivado-docker

Vivado installed into a docker image for CI purposes.

This repo and its files were originally forked from the Raytheon BBN-Q repo of the [same name](https://github.com/BBN-Q/vivado-docker), but have been modified for use with Vivado 2015.4 and the Zynq-7000 SoC series.

## Build instructions

1. Copy the compressed Vivado tar file into the directory.
    ```shell
    cp /path/to/Vivado/download.tar.gz ./
    ```
2. Copy your Vivado `Xilinx.lic` file into the directory.
3. Potentialy modify the `install_config.txt` to change the install options.
4. Build the image (will take about 10 minutes) passing in a build arg
    ```shell
    docker build --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_Lin_2015.4_1118_2 --build-arg VIVADO_VERSION=2015.4 -t vivado:2015.4 .
    ```

## Running

### CLI Only
To run Vivado in only batch mode, it is sufficient to run
``` shell
podman run -it vivado:2015.4
```
to start the container. Then launch Vivado with the following options
``` shell
/opt/Xilinx/Vivado/2015.4/bin/vivado -mode batch
```
### GUI Mode
For development work with the GUI you can invoke `docker run` with the following options
``` shell
docker run --security-opt label=disable -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY -v /run/user/$(id -u)/:/run/user/1000/ -e XDG_RUNTIME_DIR=/run/user/1000/ -e PULSE_SERVER=/run/user/1000/pulse/native --ipc host -it vivado:2015.4
```
This has been tested only on Fedora 32 with `podman` substituted for `docker` (podman serves as nearly a drop-in substitute for docker). If this command does not work, you may have to fiddle with the options and the X11 settings.
Once inside, simply launch Vivado with 
``` shell
/opt/Xilinx/Vivado/2015.4/bin/vivado
```
So far, I have only successfully run this command and launched the GUI with root privileges. If it is run without root, you may receive the following message, or something similar.
```
Error: cannot open display :0
```

## Current Issues

Currently I am working on modifying the Dockerfile to create a user who can invoke `sudo` rather than running the container as root, since it is both more secure and more in line with the standard Vivado workflow.