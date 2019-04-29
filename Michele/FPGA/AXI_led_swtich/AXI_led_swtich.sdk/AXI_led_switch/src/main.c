#include "xparameters.h"

//#define XPAR_MYIP_LED_SWITCH_0_S00_AXI_BASEADDR 0x43C00000;
#define MYIP_LED_SWITCH_S00_AXI_SLV_REG0_OFFSET 0
#define MYIP_LED_SWITCH_S00_AXI_SLV_REG1_OFFSET 4
#define MYIP_LED_SWITCH_S00_AXI_SLV_REG2_OFFSET 8
#define MYIP_LED_SWITCH_S00_AXI_SLV_REG3_OFFSET 12

int main(void){



	int * my_ls_base = (int*) XPAR_MYIP_LED_SWITCH_0_S00_AXI_BASEADDR;
	int * my_ls_switch_out = (int*) XPAR_MYIP_LED_SWITCH_0_S00_AXI_BASEADDR + MYIP_LED_SWITCH_S00_AXI_SLV_REG0_OFFSET;
	int * my_ls_led_in = (int*) (XPAR_MYIP_LED_SWITCH_0_S00_AXI_BASEADDR + MYIP_LED_SWITCH_S00_AXI_SLV_REG1_OFFSET);

	*my_ls_led_in = 0x0000000F;
	*my_ls_led_in = 0x00000002;
	*my_ls_led_in = 0x00000003;
	*my_ls_led_in = 0x00000005;
	*my_ls_led_in = 0x0000000A;

	int i=1;

	while(i>0){
		i++;
	}

	return 0;

}
