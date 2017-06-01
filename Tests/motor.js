var mraa = require('mraa');

    var Motor = function (D1Pin, D2Pin, SpeedPin, HomePin, SensePin, mcuStream) {
    var self = this;

    self.MotorPin1 = new mraa.Gpio(D1Pin);
    self.MotorPin1.dir(mraa.DIR_OUT);
    self.MotorPin2 = new mraa.Gpio(D2Pin);
    self.MotorPin2.dir(mraa.DIR_OUT);
    self.MotorPinSpeed = new mraa.Pwm(SpeedPin);  //PWM available on default swizzler positions. (3,5,6,9)
    self.MotorPinSpeed.period_us(700);
    self.MotorPinSpeed.enable(true);
    self.mcu = mcuStream;
    self.positionDelta = 10;  //How many counter positions is close enough?
    self.counter = 0;
    self.max = 0;
    self.target = -1;    //What counter position to goto
    self.mcu.write("M"); //Ask the MCU to get the maximum value

    self.mcu.on('data', function(data) {
    switch (data.substring(0,1)) {
        case "C": {
            self.counter = data.substring(1);
            if (self.InPosition()) {
                console.log("Position found at %d", self.counter);
                self.Stop();
                self.target = -1;  
            }
            setTimeout(function() {self.mcu.write("C") },10);
            break;
        }
        case "M": {
            self.max = data.substring(1);
            break;
        }
        default:  
            console.log("Unexpected data recieved %s",data);
    }
    });

    self.mcu.on('error', function(error) {  
        console.log('Motor MCU error occurred %s', error);
    });

    self.Reset = function() {
        //Set the motor running for long enough to trigger a reset then stop
        var timeForOneRev = 1000;
        self.Forward();
        setTimeout(function() { self.Stop() },timeForOneRev);
        setTimeout(function() { self.mcu.write("C") },timeForOneRev);
    }

    self.Forward = function() {
        self.mcu.write("U");
        self.MotorPin1.write(1);
        self.MotorPin2.write(0);
    }

    self.Reverse = function() {
        self.mcu.write("D");
        self.MotorPin1.write(0);
        self.MotorPin2.write(1);
    }

    self.Stop = function() {
        self.mcu.write("S");
        self.target=-1;
        self.MotorPin1.write(0);
        self.MotorPin2.write(0);
    }

    self.Speed = function(percent) {
        self.MotorPinSpeed.write(percent);
    }

    self.Position = function() {
        return self.counter;
    }

    self.Max = function() {
        return self.max;
    }

    self.Distance = function(newPosition) {
        //What is the distance from the current position to the new position
        var p = self.Position();
        var m = self.Max();
        var D1 = newPosition - p;
        var D2 = (m - p) + newPosition;
        if (Math.abs(D1) < Math.abs(D2))
            return D1;
        else
            return D2;
    }

      self.Direction = function(newPosition) {
            return Math.sign(self.Distance(newPosition))
      }

      self.InPosition = function() {
          if (self.target == -1) return false; //Not going to a position
          return ((self.Distance() * self.Direction()) < self.positionDelta);
      }

      self.Goto = function(newPosition) {
            self.target = newPosition;
            if (self.InPosition()) {
                self.target=-1;
                return;
            }
            if (self.Direction(newPosition) > 0) {
                self.Forward();
            }
            else {
                self.Reverse();
            }
      }
};

    module.exports = Motor;