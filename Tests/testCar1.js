var motor = require('./motorCar.js');

/*
Motor Speed - Pin 6 (PWM)
Motor 1 Direction - Pin 7,8
Motor 2 Direction - Pin A3, A4
*/

//AIO pins are treated as 0-5 in mraa_aio_init() but as 14-19 for everything else. Therefore use mraa_gpio_init(14) to use A0 as a GPIO
var m = new motor(7, 8,17,18, 6);

m.Speed(0.9); //Start things gentle
m.Forward();
setTimeout(function() {m.Reverse()}, 2000);
setTimeout(function() {m.Stop()}, 4000);


process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    m.Stop();
    process.exit();
});
