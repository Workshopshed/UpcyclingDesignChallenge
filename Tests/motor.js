var mraa = require('mraa');

    var Motor = function (D1Pin, D2Pin, SpeedPin, HomePin, SensePin) {
    
    this.MotorPin1 = new mraa.Gpio(D1Pin);
    this.MotorPin1.dir(mraa.DIR_OUT);
    this.MotorPin2 = new mraa.Gpio(D2Pin);
    this.MotorPin2.dir(mraa.DIR_OUT);
    this.MotorPinSpeed = new mraa.Pwm(SpeedPin);  //PWM available on default swizzler positions. (3,5,6,9)
    this.MotorPinSpeed.period_us(700);
    this.MotorPinSpeed.enable(true);

    this.Forward = function() {
        this.MotorPin1.write(1);
        this.MotorPin2.write(0);
        //Todo: Write to UART
    }

    this.Reverse = function() {
        this.MotorPin1.write(0);
        this.MotorPin2.write(1);
        //Todo: Write to UART
    }

    this.Stop = function() {
        this.MotorPin1.write(0);
        this.MotorPin2.write(0);
    }

    this.Speed = function(percent) {
        this.MotorPinSpeed.write(percent);
    }

};

    module.exports = Motor;