var m;
 
m = require('mraa');

var motor = require('./motor.js');

var m1 = new motor(1,2,3,4,5);

m1.Forward();
m1.Speed(10);
m1.Stop();

//TODO:
//Add UART support for the MRAA Stub https://iotdk.intel.com/docs/master/mraa/node/classes/uart.html
//Send a request to https://github.com/intel-iot-devkit/mraa/tree/master/jsstub
//Fill out missing methods on the motor class
