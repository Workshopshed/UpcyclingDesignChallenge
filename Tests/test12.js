//Test with the MiniBreakout / Outputs
//Todo: Modify this to use the motorFurby class

var Furby = require('./motorFurby.js');

var M1 =    new mraa.Gpio(19);
var M2 =    new mraa.Gpio(20);
var speed = new mraa.Pwm(21);  

setInterval(function () {
        value = value + step;
        if (value <= 0 || value >= 1) {
            step = -step;
        }
        speed.write(value);
    } , 20);

var ledState = true;

setInterval(function () { 
	M1.write(ledState?1:0);
        M2.write(ledState?1:0);
	ledState = !ledState;
}, 1000);

setInterval(function () {} , 1000); //Do nothing, stops the apps exiting

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    speed.write(0);
    M1.write(0);
    M2.write(0);
    process.exit();
});

