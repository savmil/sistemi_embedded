#include "xparameters.h"
#include "myled_controller.h"
#include "xscugic.h"
#include <stdio.h>
#include "xil_io.h"
void set_reg(void * base_addr,void * offset, int * value);
unsigned int read_reg(void * base_addr,void * offset);
static XScuGic gic;
//istanzio un struttura che gestisce il driver
/*
 * XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR questo sono i button
 * XPAR_MYLED_CONTROLLER_1_S00_AXI_BASEADDR questo sono i led
 * XPAR_MYLED_CONTROLLER_2_S00_AXI_BASEADDR questo sono gli switch
 * MYLED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET input
 * MYLED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET enable
 */
int SetupInterruptSystem();
int main()
{
	//void * base_addr=(void*) XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR;
	//void * reg_3=(void *)base_addr+MYLED_CONTROLLER_S00_AXI_SLV_REG3_OFFSET;
	int value;
	if (SetupInterruptSystem())
		{
		printf("errore\n");
		}
	while(1)
	{
		value= 0xAFFFFFFF;
		set_reg(XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR,MYLED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET,&value);
		value= 0x00000000;
		set_reg(XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR,MYLED_CONTROLLER_S00_AXI_SLV_REG1_OFFSET,&value);
		value= 0xAFFFFFFF;
				set_reg(XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR,MYLED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET,&value);
		printf("il valore del registro è %08x \n", read_reg(XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR,MYLED_CONTROLLER_S00_AXI_SLV_REG3_OFFSET) );
		value=0x00000000;
		set_reg(XPAR_MYLED_CONTROLLER_0_S00_AXI_BASEADDR,MYLED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET,&value);
		/*printf("valore gic %d\n",*gic);
		*((int*) base_addr)=value;
		printf("valore gic %d\n",*gic)
		*((int*) base_addr)=0x00000000;
		printf("valore gic %d\n",*gic);
		base_addr=(void*) XPAR_MYLED_CONTROLLER_1_S00_AXI_BASEADDR;
		printf("valore gic %d\n",*gic);
			*((int*) base_addr)=value;
			printf("valore gic %d\n",*gic);
			*((int*) base_addr)=0x00000000;
			printf("valore gic %d\n",*gic);
				base_addr=(void*) XPAR_MYLED_CONTROLLER_2_S00_AXI_BASEADDR;
				printf("valore gic %d\n",*gic);
					*((int*) base_addr)=value;
					printf("valore gic %d\n",*gic);
					*((int*) base_addr)=0x00000000;
					printf("valore gic %d\n",*gic);*/

	}
}
void set_reg (void* base_addr,void* offset,int* value)
{
	void * reg= (void*)(base_addr+(int)offset);
	*((int*)reg)=*value;
}
unsigned int read_reg(void * base_addr,void * offset)
{
	void * reg= (void*)(base_addr+(int)offset);
	return *((unsigned int*) reg);
}

void PIsr(){    //routine avviata all' interrupt
    printf("ciao \n");
    XScuGic_Disable(&gic, XPAR_FABRIC_MYLED_CONTROLLER_0_INTERRUPT_INTR);
}
int SetupInterruptSystem()  {
    int result;



    XScuGic_Config *IntcConfig;
    //puntatore che conterrà la configurazione del gic
    IntcConfig = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
    // mi restituisce un puntatore al valore della configurazione del gic
    if (IntcConfig == NULL)    {
        return XST_FAILURE;
    }
    result = XScuGic_CfgInitialize(&gic, IntcConfig,    IntcConfig->CpuBaseAddress);
    //inizializza la struttura XscuGic con i valori del registro xscugic l' indirizzo base del device che deve essere interrotto

    if (result != XST_SUCCESS)    {
        return XST_FAILURE;
    }
    result = XScuGic_Connect(&gic, XPAR_FABRIC_MYLED_CONTROLLER_0_INTERRUPT_INTR, (Xil_ExceptionHandler) PIsr, IntcConfig->CpuBaseAddress);
    //associa all' interrupt dato dal secondo parametro, un handler da eseguire, il quarto parametro è un parametro che è possibile passare all' handler
    if (result != XST_SUCCESS)    {
        return result;
    }
    XScuGic_Enable(&gic, XPAR_FABRIC_MYLED_CONTROLLER_0_INTERRUPT_INTR);
    //abilita la linea di interrupt
    XScuGic_SetPriorityTriggerType(&gic, XPAR_FABRIC_MYLED_CONTROLLER_0_INTERRUPT_INTR,0x00, 0x3);
    // setta la priorità




    //Xil_ExceptionInit();

    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler, &gic);
    //assoccia interrupt handler del gic con l' interrupt hardware che arriva
    Xil_ExceptionEnable();
    //abilita le interruzioni nel processore ARM

    return XST_SUCCESS;
}
