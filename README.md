
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

The `Dockerfile` sets up a `vivado` user to avoid running as root. I have only considered running Vivado in `batch` mode for running CI simulations and building bit files. For development work with the GUI you may have to fiddle with X11 settings.
