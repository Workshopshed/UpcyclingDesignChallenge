var mraa = require('mraa');

    var Motor = function (D1Pin, D2Pin, SpeedPin, HomePin, SensePin, mcuCommands, mcuMessages) {
    var self = this;

    self.MotorPin1 = new mraa.Gpio(D1Pin);
    self.MotorPin1.dir(mraa.DIR_OUT);
    self.MotorPin2 = new mraa.Gpio(D2Pin);
    self.MotorPin2.dir(mraa.DIR_OUT);
    self.MotorPinSpeed = new mraa.Pwm(SpeedPin);  //PWM available on default swizzler positions. (3,5,6,9)
    self.MotorPinSpeed.period_us(700);
    self.MotorPinSpeed.enable(true);
    self.mcuCommands = mcuCommands;
    self.mcuMessages = mcuMessages;
    self.positionDelta = 10;  //How many counter positions is close enough?
    self.counter = 0;
    self.max = 0;
    self.target = -1;    //What counter position to goto
    self.mcuCommands.write("M"); //Ask the MCU to get the maximum value

    self.mcuMessages.on('data', function(message) {
    var data = message.toString();
    switch (data.substring(0,1)) {
        case "C": {
            self.counter = data.substring(1);
            if (self.inPosition()) {
                console.log("Position found at %d", self.counter);
                self.stop();
                self.target = -1;  
            }
            setTimeout(function() {self.mcuCommands.write("C") },10);
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

    self.mcuMessages.on('error', function(error) {  
        console.log('Furby Motor MCU error occurred %s', error);
    });

    self.reset = function() {
        //Set the motor running for long enough to trigger a reset then stop
        var timeForOneRev = 1000;
        self.forward();
        setTimeout(function() { self.stop() },timeForOneRev);
        setTimeout(function() { self.mcuCommands.write("C") },timeForOneRev);
    }

    self.forward = function() {
        self.mcuCommands.write("U");
        self.MotorPin1.write(1);
        self.MotorPin2.write(0);
    }

    self.reverse = function() {
        self.mcuCommands.write("D");
        self.MotorPin1.write(0);
        self.MotorPin2.write(1);
    }

    self.stop = function() {
        self.target=-1;
        self.MotorPin1.write(0);
        self.MotorPin2.write(0);
    }

    self.speed = function(percent) {
        self.MotorPinSpeed.write(percent);
    }

    self.position = function() {
        return self.counter;
    }

    self.max = function() {
        return self.max;
    }

    self.distance = function(newPosition) {
        //What is the distance from the current position to the new position
        var p = self.position();
        var m = self.max();
        var D1 = newPosition - p;
        var D2 = (m - p) + newPosition;
        if (Math.abs(D1) < Math.abs(D2))
            return D1;
        else
            return D2;
    }

      self.direction = function(newPosition) {
            return Math.sign(self.distance(newPosition))
      }

      self.inPosition = function() {
          if (self.target == -1) return false; //Not going to a position
          return ((self.distance() * self.direction()) < self.positionDelta);
      }

      self.goto = function(newPosition) {
            self.target = newPosition;
            if (self.inPosition()) {
                self.target=-1;
                return;
            }
            if (self.direction(newPosition) > 0) {
                self.forward();
            }
            else {
                self.reverse();
            }
      }
};

    module.exports = Motor;