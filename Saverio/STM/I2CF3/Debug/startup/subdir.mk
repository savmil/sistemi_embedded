################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../startup/startup_stm32f303xc.s 

OBJS += \
./startup/startup_stm32f303xc.o 


# Each subdirectory must supply rules for building sources it contributes
startup/%.o: ../startup/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Assembler'
	@echo $(PWD)
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -I"/home/saverio/workspace/I2CF3/HAL_Driver/Inc/Legacy" -I"/home/saverio/workspace/I2CF3/Utilities/STM32F3-Discovery" -I"/home/saverio/workspace/I2CF3/Utilities/Components/lsm303dlhc" -I"/home/saverio/workspace/I2CF3/Utilities/Components/Common" -I"/home/saverio/workspace/I2CF3/Utilities/Components/l3gd20" -I"/home/saverio/workspace/I2CF3/inc" -I"/home/saverio/workspace/I2CF3/CMSIS/device" -I"/home/saverio/workspace/I2CF3/CMSIS/core" -I"/home/saverio/workspace/I2CF3/HAL_Driver/Inc" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

