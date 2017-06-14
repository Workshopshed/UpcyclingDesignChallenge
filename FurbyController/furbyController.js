var queue = require('queue');
var motor = require('./motorFurby.js');
var soundplayer = require("sound-player");

//todo: Add sound into this too

var controller = function() {

  this.q = queue();
  this.q.concurrency = 1;
  this.player = new soundplayer(options);
  this.playing = false;

  this.player.on('complete', function() {
    this.playing = false;
  });

  this.player.on('error', function(err) {
    this.playing = false;
    console.log('Audio Player error occurred:', err);
  });

  //Expect a movement object formed of a command and timer to be passed { action: action, timeOut: timeout}
  this.queueMovement = function(move) {

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
        switch (action) {
            case "BUMP": {
                
                break;
            }
            case "BLABLA": {

                break;
            }
        default:  
             break; //Nothing matches
        }


        this.doSound(action);
   }

   this.doSound = function(action) {
        //Todo: Play a sound to match the action

   }

    this.shutdown = function() {
        //Todo: If we need to shutdown any hardware handles etc.
        this.player.stop();

    }
}

module.exports = new controller();