#include "mcu_api.h"
#include "mcu_errno.h"
volatile int counter;
volatile int direction;
int maxPulses;

 int IRQpulse(int req)
 {
   counter += direction;
   if (counter < 0) {
    counter = maxPulses;
   }
   if (counter > maxPulses) {
    counter = 0;
   }
   debug_print(DBG_INFO, "Counter: %d\n",counter);
   return IRQ_HANDLED;
 }

 int IRQreset(int req)
 {
   counter = 0;
   debug_print(DBG_INFO, "Reset.\n");
   return IRQ_HANDLED;
 }

 void mcu_main()
 {
 char buf[64];
 char response[20];
    int retCode;
    int len;
    debug_print(DBG_INFO, "mcu app starting...\n");
    direction = 1;
    maxPulses = 208;    //Max pulses per revolution, was determined experimentally
    gpio_setup(28, 0);  /* set GP28 MRAA(8) Pin J17-9 as input*/
    gpio_register_interrupt(28, 1, IRQpulse);
    gpio_setup(111, 0);  /* set GP111 MRAA(9) Pin J17-10 as input*/
    gpio_register_interrupt(111, 1, IRQreset);
    while (1)
    {
     //Wait for command from host
     do {
      retCode = host_receive((unsigned char *)buf, 64);
         mcu_sleep(10);
     } while (retCode <= 0);
     switch(buf[0]) {
        case 'C'  :
         debug_print(DBG_INFO, "Counter: %d\n", counter);
         debug_print(DBG_INFO, "Direction: %d\n", direction);
         len = mcu_snprintf(response, 20, "C%d\n", counter);
         host_send((unsigned char*)response, len);
            break;
        case 'M'  :
         debug_print(DBG_INFO, "Max: %d\n", maxPulses);
         len = mcu_snprintf(response, 20, "M%d\n", maxPulses);
         host_send((unsigned char*)response, len);
            break;
        case 'U'  :
        debug_print(DBG_INFO, "Up\n");
        direction = 1;
           break;
        case 'D'  :
        debug_print(DBG_INFO, "Down\n");
        direction = -1;
           break;
     }
    }
 }
