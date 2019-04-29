connect -url tcp:127.0.0.1:3121
source /home/saverio/zybo/uart_ip/uart_ip.sdk/uart_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279651570A"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279651570A" && level==0} -index 1
fpga -file /home/saverio/zybo/uart_ip/uart_ip.sdk/uart_wrapper_hw_platform_0/uart_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279651570A"} -index 0
loadhw -hw /home/saverio/zybo/uart_ip/uart_ip.sdk/uart_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279651570A"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279651570A"} -index 0
dow /home/saverio/zybo/uart_ip/uart_ip.sdk/prova_uart/Debug/prova_uart.elf
configparams force-mem-access 0
bpadd -addr &main
