//Simple function to test the indicator

var platform = require('os').platform();
var m;
 
if (platform === 'win32') {
    m = require('mraaStub'); //also needs winston
} else {
    m = require('mraa');
}

var myLed = new m.Gpio(13); //LED hooked up to digital pin 13 (or built in pin on Galileo Gen1 & Gen2)
myLed.dir(m.DIR_OUT); //set the gpio direction to output

function indicate() {
    var count = 1;
    var ledState = false;
    var intervalId = setInterval(function() {
    	myLed.write(ledState?1:0);
        ledState = !ledState;
				if (count++ >= 10) {
                clearInterval(intervalId);
            }
    }, 500);
};

indicate();