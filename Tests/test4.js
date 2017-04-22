
var mraa = require('mraa');
console.log('MRAA Version: ' + mraa.getVersion());

var pwm = new mraa.Pwm(6);  //PWM available on default swizzler positions. (3,5,6,9)

var forwards = new mraa.Gpio(7);
var backwards = new mraa.Gpio(8);

forwards.dir(mraa.DIR_OUT);
backwards.dir(mraa.DIR_OUT);

var dir = true;

var value = 0.0;
var step = 0.01;

pwm.period_us(700);
pwm.enable(true);

toggleDirection();

setInterval(function () {
    value = value + step;
    if (value <= 0 || value >= 1) {
       if (step <= 0) {
            toggleDirection();
        }
        step = -step;
    }
    pwm.write(value);
    } , 50);

function toggleDirection() {
    forwards.write(dir?1:0);
    backwards.write(dir?0:1);
    dir = !dir;
    }

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    pwm.write(0);
    forwards.write(0);
    backwards.write(0);
    process.exit();
});
