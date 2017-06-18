var util         = require("util");
var mraa = require('mraa');
var EventEmitter = require("events").EventEmitter;

var bumper = function() {
   var self = this;
   var bumpfPrevious = -1;
   var bumpbPrevious = -1;
   var bumpfPin = new mraa.Aio(0); //setup access analog input pin 0 (Front bumper)
   var bumpbPin = new mraa.Aio(1); //setup access analog input pin 1 (Back bumper)

   //Monitor the bumper analogue pin and raise events if it changes
   setInterval(function () {
      var analogValueFloatF = bumpfPin.readFloat();
      var newvalF = floatToSwitch(analogValueFloatF);
      if (bumpfPrevious == -1) {
          bumpfPrevious  = newvalF;
      }      
      if (newvalF != bumpfPrevious) {
          self.emit('bumper','bumperf' + newvalF.toString());
          bumpfPrevious  = newvalF;
      }
   } , 100);

   setInterval(function () {
      var analogValueFloatB = bumpbPin.readFloat();
      var newvalB = floatToSwitch(analogValueFloatB);
      if (bumpbPrevious == -1) {
          bumpbPrevious  = newvalB;
      }
      if (newvalB != bumpbPrevious) {
          self.emit('bumper','bumperb' + newvalB.toString());
          bumpbPrevious  = newvalB;
      }
   } , 100);

  var BumpEnum = {
    None: 0,
    Left: 1,
    Right: 2,
    Both: 3
  };

  //Scale the input to one of our 4 values depending on
  //which of the two switches are pressed
  function floatToSwitch(value) {
      if (value < 0.45) return BumpEnum.Both;
      if (value < 0.58) return BumpEnum.Left;
      if (value < 0.83) return BumpEnum.Right;
      if (value >= 0.83) return BumpEnum.None;
      return 4;
  }

    this.shutdown = function() {
        //Todo: If we need to shutdown any hardware handles etc.
    }
}

1
util.inherits(bumper, EventEmitter);

module.exports = bumper;