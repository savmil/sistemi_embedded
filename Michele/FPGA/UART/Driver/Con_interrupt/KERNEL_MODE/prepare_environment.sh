#!/bin/bash
VIVADO_PATH=$HOME/Vivado
VIVADO_VERS=2018.3
SDK_PATH=$HOME/SDK
SDK_VERS=2018.3
source $VIVADO_PATH/$VIVADO_VERS/settings64.sh
source $SDK_PATH/$SDK_VERS/settings64.sh
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=$HOME/Scrivania/UART_KERNEL_MODE/linux-xlnx/tools/:$PATH

