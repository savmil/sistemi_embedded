################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../startup/startup_stm32f407xx.s 

OBJS += \
./startup/startup_stm32f407xx.o 


# Each subdirectory must supply rules for building sources it contributes
startup/%.o: ../startup/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Assembler'
	@echo $(PWD)
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -I"/home/saverio/workspace/SPIF4/Utilities/Components/ili9325" -I"/home/saverio/workspace/SPIF4/Utilities/Components/s25fl512s" -I"/home/saverio/workspace/SPIF4/Utilities/Components/cs43l22" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ili9341" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ampire480272" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q512a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/s5k5cag" -I"/home/saverio/workspace/SPIF4/Utilities/Components/mfxstm32l152" -I"/home/saverio/workspace/SPIF4/CMSIS/device" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ts3510" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q128a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/st7735" -I"/home/saverio/workspace/SPIF4/HAL_Driver/Inc/Legacy" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lis302dl" -I"/home/saverio/workspace/SPIF4/Utilities/Components/otm8009a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/stmpe1600" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ov2640" -I"/home/saverio/workspace/SPIF4/Utilities/Components/Common" -I"/home/saverio/workspace/SPIF4/Utilities/Components/l3gd20" -I"/home/saverio/workspace/SPIF4/HAL_Driver/Inc" -I"/home/saverio/workspace/SPIF4/Utilities" -I"/home/saverio/workspace/SPIF4/Utilities/Components/stmpe811" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lis3dsh" -I"/home/saverio/workspace/SPIF4/Utilities/Components/wm8994" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q256a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ls016b8uy" -I"/home/saverio/workspace/SPIF4/inc" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ft6x06" -I"/home/saverio/workspace/SPIF4/Utilities/STM32F4-Discovery" -I"/home/saverio/workspace/SPIF4/Utilities/Components/exc7200" -I"/home/saverio/workspace/SPIF4/Utilities/Components/st7789h2" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ampire640480" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lsm303dlhc" -I"/home/saverio/workspace/SPIF4/CMSIS/core" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


