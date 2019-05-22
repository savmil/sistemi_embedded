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
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -I"/home/andrea/Ac6Workspace/CRC_Revisited/HAL_Driver/Inc/Legacy" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/STM32F3-Discovery" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/lsm303dlhc" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/Common" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/l3gd20" -I"/home/andrea/Ac6Workspace/CRC_Revisited/inc" -I"/home/andrea/Ac6Workspace/CRC_Revisited/CMSIS/device" -I"/home/andrea/Ac6Workspace/CRC_Revisited/CMSIS/core" -I"/home/andrea/Ac6Workspace/CRC_Revisited/HAL_Driver/Inc" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


