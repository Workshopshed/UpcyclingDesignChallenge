var motor = require('motorCar.js');

/*
Motor Speed - Pin 6 (PWM)
Motor 1 Direction - Pin 7,8
Motor 2 Direction - Pin A3, A4
*/

//AIO pins are treated as 0-5 in mraa_aio_init() but as 14-19 for everything else. Therefore use mraa_gpio_init(14) to use A0 as a GPIO
var m = new motor(7, 8,17,18, 6);

m.Forward();
setTimeout(m.Stop(), 1000);

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    pwm.write(0);
    process.exit();
});
