//Lighting Controller

var mraa = require('mraa');

var Lights = function (LIndicatorPin, RIndicatorPin, HeadlightsPin, BrakeLightsPin) {
    var self = this;

    self.LPin = new mraa.Gpio(LIndicatorPin);
    self.LPin.dir(mraa.DIR_OUT);
    self.RPin = new mraa.Gpio(RIndicatorPin);
    self.RPin.dir(mraa.DIR_OUT);
    self.BPin = new mraa.Gpio(BrakeLightsPin);
    self.BPin.dir(mraa.DIR_OUT);    
    self.HPin = new mraa.Pwm(HeadlightsPin);  //PWM available on default swizzler positions. (3,5,6,9)

    //Start off disabled
    self.LPin.write(1); //Indicators and brakes are negative logics
    self.RPin.write(1);
    self.BPin.write(1);
    self.HPin.write(0);      

    self.HPin.period_us(1000);
    self.HPin.enable(true);

    self.Headlights = function(percent) {
        self.HPin.write(percent);
    }
    
    self.Left = function() {
        self.indicate(self.LPin);
    };        
        
    self.Right = function() {
        self.indicate(self.RPin);
    };   
        
    self.Flash = function() {
        self.HPin.write(1);
        setTimeout(function() { self.HPin.write(0); },300);
    };
        
    self.Brake = function() {
        self.BPin.write(1);
        setTimeout(function() { self.BPin.write(0); },1000);
    };

    self.indicate = function(pin) {
    var count = 1;
    var ledState = true;
    var intervalId = setInterval(function() {
    	pin.write(ledState?0:1);
        ledState = !ledState;
				if (count++ >= 10) {
                clearInterval(intervalId);
            }
        }, 500);
    };
}

    module.exports = Lights;

