var queue        = require('queue');
var util         = require("util");
var mraa = require('mraa');
var EventEmitter = require("events").EventEmitter;

var controller = function() {

  this.q = queue();
  this.q.concurrency = 1;

  //Expect a movement object formed of a command and timer to be passed { action: action, timeOut: timeout}
  this.addMovement = function(move) {

     var c = this;

     if (move.action == "RUN") {
        this.run();
        return;
     }

     if (move.action == "HALT") {
        this.halt();
        return;
     }

     if (typeof move.timeOut == 'undefined') {
        move.timeout = 10; //Default to 10ms
     }

     c.q.push(function(done) {
                setTimeout(function() {
                    c.doMovement(move.action,move.timeOut);
                    done();
                }, move.timeOut);
     });
    }

    this.halt = function() {
        this.q.stop();
    }

    this.run = function() {
       this.q.start(function(err) {
          if (err != null) {
            console.log(err);
          }
	    });
    }

    this.doMovement = function(action,timeout) {
        //Todo: this is where we'd talk to the hardware
        console.log(action);
        console.log(timeout);

	//Tell the listener the action has happened
        this.emit('action',action);
   }

   var bumpPrevious = -1;
   var analogPin0 = new mraa.Aio(0); //setup access analog input pin 0

   //Monitor the bumper analogue pin and raise events if it changes
   setInterval(function () {
      var analogValueFloat = analogPin0.readFloat();
      var newval = floatToSwitch(analogValueFloat)
      if (newval != bumpPrevious) {
          this.emit('action','bumper' + newval.toString());
          bumpPrevious  = newval;
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
util.inherits(controller, EventEmitter);

module.exports = new controller();