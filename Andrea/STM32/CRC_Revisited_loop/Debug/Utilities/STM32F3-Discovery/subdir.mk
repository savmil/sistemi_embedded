################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Utilities/STM32F3-Discovery/stm32f3_discovery.c \
../Utilities/STM32F3-Discovery/stm32f3_discovery_accelerometer.c \
../Utilities/STM32F3-Discovery/stm32f3_discovery_gyroscope.c 

OBJS += \
./Utilities/STM32F3-Discovery/stm32f3_discovery.o \
./Utilities/STM32F3-Discovery/stm32f3_discovery_accelerometer.o \
./Utilities/STM32F3-Discovery/stm32f3_discovery_gyroscope.o 

C_DEPS += \
./Utilities/STM32F3-Discovery/stm32f3_discovery.d \
./Utilities/STM32F3-Discovery/stm32f3_discovery_accelerometer.d \
./Utilities/STM32F3-Discovery/stm32f3_discovery_gyroscope.d 


# Each subdirectory must supply rules for building sources it contributes
Utilities/STM32F3-Discovery/%.o: ../Utilities/STM32F3-Discovery/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DSTM32 -DSTM32F3 -DSTM32F30 -DSTM32F303VCTx -DSTM32F3DISCOVERY -DDEBUG -DSTM32F303xC -DUSE_HAL_DRIVER -I"/home/andrea/Ac6Workspace/CRC_Revisited/HAL_Driver/Inc/Legacy" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/STM32F3-Discovery" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/lsm303dlhc" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/Common" -I"/home/andrea/Ac6Workspace/CRC_Revisited/Utilities/Components/l3gd20" -I"/home/andrea/Ac6Workspace/CRC_Revisited/inc" -I"/home/andrea/Ac6Workspace/CRC_Revisited/CMSIS/device" -I"/home/andrea/Ac6Workspace/CRC_Revisited/CMSIS/core" -I"/home/andrea/Ac6Workspace/CRC_Revisited/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

