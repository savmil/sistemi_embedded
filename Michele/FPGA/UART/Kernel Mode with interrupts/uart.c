#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SIZE 32

int main(){

	int rx_reg;
	u_int8_t buffer[4], chunk;
	int buffer_size = 0;
	int j;
	u_int32_t data_to_send;
	u_int32_t data_received = 0;
	char data_in [SIZE]; 

	buffer_size = 0;
	data_to_send = 3193847990;
	
	printf("Valore totale  da mandare: %08x\n\n", data_to_send);

	FILE* fp_write;
	FILE* fp_read;
	
	printf("Divisione in chunk...\n");

	for(j=0; j<4; j++){

		chunk = (data_to_send >> j*8) & 255;

		if(chunk == 0){
			buffer_size = j;
			goto skip;
		}

		buffer[j] = chunk;
		buffer_size ++;

		printf("Buffer[%d]= %02x\n",j,buffer[j]);
	}
	
	skip:
	
	printf("\n---Inizio trasmissione---\n");

	for(j=0; j<buffer_size; j++){
		
		printf("\nTrasmissione chunk [%d]\n", j);
		
		fp_write = fopen("/proc/my_uart_int", "w");
		if(fp_write == NULL) {
			printf("Cannot open /proc/my_uart_int dor write\n");
		return -1;
		}
		
		fprintf(fp_write, "%d", buffer[j]);
		fflush(fp_write);
		printf("Trasmesso valore %02x\n", buffer[j]);
		
		//sleep(2);
		fclose(fp_write);
		
		fp_read = fopen("/proc/my_uart_int", "r");
        if(fp_read == NULL) {
	     	 printf("Cannot open /proc/my_uart_int for read\n");
  	      return -1;
		}
		
		fgets(data_in, 1024, fp_read);
		rx_reg = atoi(data_in);
		printf("Ricevuto valore %02x\n", rx_reg);
		data_received = data_received | ((rx_reg & 255) << (j)*8);
		printf("Valore totale ricevuto: %08x\n", data_received);
		
		fclose(fp_read);
	}
	
	return 0;
}
