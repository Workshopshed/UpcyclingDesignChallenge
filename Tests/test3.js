
var mraa = require('mraa');
console.log('MRAA Version: ' + mraa.getVersion());

var pwm = new mraa.Pwm(6);  //PWM available on default swizzler positions. (3,5,6,9)

var value = 0.0;
var step = 0.01;

pwm.period_us(700);
pwm.enable(true);

setInterval(function () {
        value = value + step;
        if (value <= 0 || value >= 1) {
            step = -step;
        }
        pwm.write(value);
    } , 20);

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    pwm.write(0);
    process.exit();
});
