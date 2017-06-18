var queue        = require('queue');
var util         = require("util");
var mraa = require('mraa');
var EventEmitter = require("events").EventEmitter;
var bumper = require('./bumper.js');
var motors = require('./motorCar.js');

var controller = function() {

  this.q = queue();
  this.q.concurrency = 1;
  this.bumpers = new bumper();
  //todo: Integrate motors

  //Expect a movement object formed of a command and timer to be passed { action: action, timeOut: timeout}
  this.addMovement = function(move) {

     var c = this;

     if (move.action == "RUN") {
        c.run();
        return;
     }

     if (move.action == "HALT") {
        c.halt();
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

   //Todo: Integrate bumpers
   this.bumpers.on('bumper', function(bump) {   
       console.log("Bump");
       //todo: Stop motors
       this.emit('action',bump);
   });

    this.shutdown = function() {
        //Todo: If we need to shutdown any hardware handles etc.
    }
}

1
util.inherits(controller, EventEmitter);

module.exports = new controller();