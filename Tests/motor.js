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
        //TODO: Write to MCU
    }

    this.Reverse = function() {
        this.MotorPin1.write(0);
        this.MotorPin2.write(1);
        //TODO: Write to MCU
    }

    this.Stop = function() {
        this.MotorPin1.write(0);
        this.MotorPin2.write(0);
    }

    this.Speed = function(percent) {
        this.MotorPinSpeed.write(percent);
    }

    this.Position = function() {
        //TODO: Write to MCU, read from MCU
        return 1;
    }

    this.Max = function() {
        //Get the maximum number of pulses per revolution from the MCU
        //TODO: Write to MCU, read from MCU
        return 1;
    }

    this.Distance = function(newPosition) {
        //What is the distance from the current position to the new position
        var p = this.Position();
        var m = this.Max();
        
    }

};

    module.exports = Motor;