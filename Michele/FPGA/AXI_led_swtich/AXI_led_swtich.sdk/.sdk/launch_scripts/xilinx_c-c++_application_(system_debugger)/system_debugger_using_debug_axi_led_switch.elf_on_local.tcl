connect -url tcp:127.0.0.1:3121
source /home/michele/Documenti/Universita/SE/Projects/AXI_led_swtich/AXI_led_swtich.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279652574A"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279652574A" && level==0} -index 1
fpga -file /home/michele/Documenti/Universita/SE/Projects/AXI_led_swtich/AXI_led_swtich.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279652574A"} -index 0
loadhw -hw /home/michele/Documenti/Universita/SE/Projects/AXI_led_swtich/AXI_led_swtich.sdk/design_1_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zybo 210279652574A"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279652574A"} -index 0
dow /home/michele/Documenti/Universita/SE/Projects/AXI_led_swtich/AXI_led_swtich.sdk/AXI_led_switch/Debug/AXI_led_switch.elf
configparams force-mem-access 0
bpadd -addr &main
