//Dual Motor class for the car

var mraa = require('mraa');

    var Motor = function (LPin1, LPin2, RPin1, RPin2, SpeedPin) {
    var self = this;

    self.Motor1Pin1 = new mraa.Gpio(LPin1);
    self.Motor1Pin1.dir(mraa.DIR_OUT);
    self.Motor1Pin2 = new mraa.Gpio(LPin2);
    self.Motor1Pin2.dir(mraa.DIR_OUT);
    self.Motor2Pin1 = new mraa.Gpio(RPin1);
    self.Motor2Pin1.dir(mraa.DIR_OUT);
    self.Motor2Pin2 = new mraa.Gpio(RPin2);
    self.Motor2Pin2.dir(mraa.DIR_OUT);        
    self.MotorPinSpeed = new mraa.Pwm(SpeedPin);  //PWM available on default swizzler positions. (3,5,6,9)

    //Start off disabled
    self.Stop();

    self.MotorPinSpeed.period_us(700);
    self.MotorPinSpeed.enable(true);

    self.Forward = function() {
        self.Motor1Pin1.write(1);
        self.Motor1Pin2.write(0);
        self.Motor2Pin1.write(1);
        self.Motor2Pin2.write(0);        
    };

    self.Left = function() {
        self.Motor1Pin1.write(1);
        self.Motor1Pin2.write(0);
        self.Motor2Pin1.write(0);
        self.Motor2Pin2.write(1);             
    };        
        
    self.Right = function() {
        self.Motor1Pin1.write(0);
        self.Motor1Pin2.write(1);
        self.Motor2Pin1.write(1);
        self.Motor2Pin2.write(0);             
    };   
        
    self.Reverse = function() {
        self.Motor1Pin1.write(0);
        self.Motor1Pin2.write(1);
        self.Motor2Pin1.write(0);
        self.Motor2Pin2.write(1);        
    };

    self.Stop = function() {
        self.Motor1Pin1.write(0);
        self.Motor1Pin2.write(0);
        self.Motor2Pin1.write(0);
        self.Motor2Pin2.write(0);        
    };

    self.Speed = function(percent) {
        self.MotorPinSpeed.write(percent);
    };

};

    module.exports = Motor;