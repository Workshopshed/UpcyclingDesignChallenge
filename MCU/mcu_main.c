#include "mcu_api.h"
#include "mcu_errno.h"
int maxPulses;
volatile int counter;
volatile int direction;
volatile int resetCountDown;

 int IRQpulse(int req)
 {
   counter += direction;
   if (counter < 0)         { counter = maxPulses; }
   if (counter > maxPulses) { counter = 0; }
   if (resetCountDown > 0)  { resetCountDown--; }
   debug_print(DBG_INFO, "Counter: %d\n",counter);
   return IRQ_HANDLED;
 }

 int IRQreset(int req)
 {
   debug_print(DBG_INFO, "Reset triggered.\n");
   if (resetCountDown > 0) { return IRQ_HANDLED; }
   resetCountDown = 10; //No more resets till 10 pules have passed.
   counter = 0;
   debug_print(DBG_INFO, "Reset counter.\n");
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
    gpio_setup(48, 0);  /* set GPIO 48 DIG7 as input*/
    gpio_register_interrupt(48, 1, IRQpulse);
    gpio_setup(49, 0);  /* set GPIO 49 DIG8 as input*/
    gpio_register_interrupt(49, 1, IRQreset);
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
