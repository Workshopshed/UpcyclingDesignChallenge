var lights = require('./lightController.js');

/*
Brake lights - Pin 1
Headlights - Pin 5 (PWM)
Indicator L - Pin 3
Indicator R - Pin 4
*/

//AIO pins are treated as 0-5 in mraa_aio_init() but as 14-19 for everything else. Therefore use mraa_gpio_init(14) to use A0 as a GPIO
var l = new lights(3,4,5,1);

l.Flash();

setTimeout(function() {l.Left()}, 2000);
setTimeout(function() {l.Right()}, 8000);

setTimeout(function() {
var count = 1;
var intervalId = setInterval(function() {
    l.Headlights(count/20.0);
            if (count++ >= 20) {
            l.Headlights(0);
            clearInterval(intervalId);
        }
    }, 200);
},15000);

/*
setTimeout(function() {m.Reverse()}, 2000);
setTimeout(function() {m.Forward()}, 4000);
setTimeout(function() {m.Left()}, 5000);
setTimeout(function() {m.Forward()}, 6000);
setTimeout(function() {m.Right()}, 7000);
setTimeout(function() {m.Forward()}, 8000);
setTimeout(function() {m.Stop()}, 10000);
*/

//setInterval(function () {} , 1000); //Do nothing, stops the apps exiting

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    m.Stop();
    process.exit();
});
