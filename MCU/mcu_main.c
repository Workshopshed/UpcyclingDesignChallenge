#include "mcu_api.h"
#include "mcu_errno.h"

volatile int counter;
volatile int direction;

 int IRQpulse(int req)
 {
   counter += direction; //TODO: What about overflow / negative?
   return IRQ_HANDLED;
 }

 int IRQreset(int req)
 {
   counter = 0;
   return IRQ_HANDLED;
 }

 void mcu_main()
 {
	char buf[64];
	char response[10];
    int retCode;
    int len;

    direction = 1;

    gpio_setup(48, 0);  /* set GPIO 48 DIG7 as input*/
    gpio_register_interrupt(48, 0, IRQpulse);
    gpio_setup(49, 0);  /* set GPIO 49 DIG8 as input*/
    gpio_register_interrupt(49, 0, IRQreset);

    while (1)
    {
    	//Wait for command from host
    	do {
    		retCode = host_receive((unsigned char *)buf, 64);
    	    mcu_sleep(10);
    	} while (retCode <= 0);

    	switch(buf[0]) {
    	   case 'C'  :
    		   len = mcu_snprintf(response, 10, "%d\n", counter);
    		   host_send((unsigned char*)response, len);
    	       break;
    	   case 'U'  :
    		  direction = 1;
    	      break;
    	   case 'D'  :
    		  direction = -1;
    	      break;
    	}
    }
 }
