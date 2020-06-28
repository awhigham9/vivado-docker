
# vivado-docker

Vivado installed into a docker image.

This repo and its files were originally forked from the Raytheon BBN-Q repo of the [same name](https://github.com/BBN-Q/vivado-docker), but have been modified for use of Vivado 2015.4 with the GUI.

## Build instructions

1. Copy the compressed Vivado tar file into the directory.
    ```shell
    cp /path/to/Vivado/download.tar.gz ./
    ```
2. Copy your Vivado `Xilinx.lic` file into the directory.
3. Potentially modify the `install_config.txt` to change the install options.
4. Build the image (will take about 10-20 minutes) passing in the build args
    ```shell
    docker build --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_Lin_2015.4_1118_2 --build-arg VIVADO_VERSION=2015.4 -t vivado:2015.4 .
    ```
5. The build creates a user ("vivado"), which has `sudo` privileges. When prompted during the build process, enter a password for this user.

## Running

### CLI Only
To run Vivado in only batch mode, it is sufficient to start the container with
``` shell
docker run -it vivado:2015.4
```
And then launch Vivado with the following option
``` shell
/opt/Xilinx/Vivado/2015.4/bin/vivado -mode batch
```
### GUI Mode
For development work with the GUI you can call `docker run` with the following options
``` shell
docker run --security-opt label=disable -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY -v /run/user/$(id -u)/:/run/user/1000/ -e XDG_RUNTIME_DIR=/run/user/1000/ -e PULSE_SERVER=/run/user/1000/pulse/native --ipc host -it vivado:2015.4
```
This has been tested only on Fedora 32 with `podman` substituted for `docker`, but should work with either due to their CLI similarity. If this command does not work, you may have to fiddle with the `docker run` options and the X11 settings. If you have a node-locked license, you should also add `--net host` to the options.
Once inside, simply launch Vivado with 
``` shell
sudo /opt/Xilinx/Vivado/2015.4/bin/vivado
```
