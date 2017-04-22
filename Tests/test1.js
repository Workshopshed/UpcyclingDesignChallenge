
var mraa = require('mraa'); 
console.log('MRAA Version: ' + mraa.getVersion()); 

var led = new mraa.Gpio(7); 
led.dir(mraa.DIR_OUT); 

var ledState = true;

setInterval(function () { 
	led.write(ledState?1:0);
	ledState = !ledState;
}, 1000);
