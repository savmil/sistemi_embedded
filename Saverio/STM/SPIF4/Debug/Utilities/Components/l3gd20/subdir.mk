################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Utilities/Components/l3gd20/l3gd20.c 

OBJS += \
./Utilities/Components/l3gd20/l3gd20.o 

C_DEPS += \
./Utilities/Components/l3gd20/l3gd20.d 


# Each subdirectory must supply rules for building sources it contributes
Utilities/Components/l3gd20/%.o: ../Utilities/Components/l3gd20/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DSTM32 -DSTM32F4 -DSTM32F407VGTx -DSTM32F407G_DISC1 -DDEBUG -DSTM32F407xx -DUSE_HAL_DRIVER -I"/home/saverio/workspace/SPIF4/Utilities/Components/ili9325" -I"/home/saverio/workspace/SPIF4/Utilities/Components/s25fl512s" -I"/home/saverio/workspace/SPIF4/Utilities/Components/cs43l22" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ili9341" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ampire480272" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q512a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/s5k5cag" -I"/home/saverio/workspace/SPIF4/Utilities/Components/mfxstm32l152" -I"/home/saverio/workspace/SPIF4/CMSIS/device" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ts3510" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q128a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/st7735" -I"/home/saverio/workspace/SPIF4/HAL_Driver/Inc/Legacy" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lis302dl" -I"/home/saverio/workspace/SPIF4/Utilities/Components/otm8009a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/stmpe1600" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ov2640" -I"/home/saverio/workspace/SPIF4/Utilities/Components/Common" -I"/home/saverio/workspace/SPIF4/Utilities/Components/l3gd20" -I"/home/saverio/workspace/SPIF4/HAL_Driver/Inc" -I"/home/saverio/workspace/SPIF4/Utilities" -I"/home/saverio/workspace/SPIF4/Utilities/Components/stmpe811" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lis3dsh" -I"/home/saverio/workspace/SPIF4/Utilities/Components/wm8994" -I"/home/saverio/workspace/SPIF4/Utilities/Components/n25q256a" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ls016b8uy" -I"/home/saverio/workspace/SPIF4/inc" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ft6x06" -I"/home/saverio/workspace/SPIF4/Utilities/STM32F4-Discovery" -I"/home/saverio/workspace/SPIF4/Utilities/Components/exc7200" -I"/home/saverio/workspace/SPIF4/Utilities/Components/st7789h2" -I"/home/saverio/workspace/SPIF4/Utilities/Components/ampire640480" -I"/home/saverio/workspace/SPIF4/Utilities/Components/lsm303dlhc" -I"/home/saverio/workspace/SPIF4/CMSIS/core" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


