################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../startup/startup_stm32.s 

OBJS += \
./startup/startup_stm32.o 


# Each subdirectory must supply rules for building sources it contributes
startup/%.o: ../startup/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Assembler'
	@echo $(PWD)
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -I"/home/saverio/Scrivania/materiale-corso-master/Ambiente_stm32/workspace_ac6/crc_F3/HAL_Driver/Inc/Legacy" -I"/home/saverio/Scrivania/materiale-corso-master/Ambiente_stm32/workspace_ac6/crc_F3/inc" -I"/home/saverio/Scrivania/materiale-corso-master/Ambiente_stm32/workspace_ac6/crc_F3/CMSIS/device" -I"/home/saverio/Scrivania/materiale-corso-master/Ambiente_stm32/workspace_ac6/crc_F3/CMSIS/core" -I"/home/saverio/Scrivania/materiale-corso-master/Ambiente_stm32/workspace_ac6/crc_F3/HAL_Driver/Inc" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


