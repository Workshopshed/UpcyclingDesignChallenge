
var mraa = require('mraa'); 
console.log('MRAA Version: ' + mraa.getVersion()); 

var button = new mraa.Gpio(5);
var pwmPin = new mraa.Gpio(7);

var ledState = true;

button.dir(mraa.DIR_IN);
led.dir(mraa.DIR_OUT);

button.isr(mraa.EDGE_RISING, function () {
	led.write(ledState?1:0);
	ledState = !ledState;
});

setInterval(function () {} , 1000); //Do nothing, stops the apps exiting

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    button.isrExit();
    led.write(0);
    process.exit();
});


