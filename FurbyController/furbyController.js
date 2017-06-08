var queue = require('queue');
var motor = require('./motorFurby.js');

//todo: Add sound into this too

var controller = function() {

  this.q = queue();
  this.q.concurrency = 1;

  //Expect a movement object formed of a command and timer to be passed { action: action, timeOut: timeout}
  this.doMovement = function(move) {

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
   }

    this.shutdown = function() {
        //Todo: If we need to shutdown any hardware handles etc.
    }
}

module.exports = new controller();