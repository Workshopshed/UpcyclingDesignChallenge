var queue = require('queue');
var motor = require('./motorFurby.js');
var soundplayer = require("./sound-player");
var fs = require('fs');

var controller = function() {

  var mcuR = fs.createReadStream('/dev/ttymcu0');
  var mcuW = fs.createWriteStream('/dev/ttymcu0');

  this.motor = new motor (19, 20, 21, 9, 8, mcuW, mcuR);
  this.motor.speed(0.8);
  this.motor.reset();

  this.q = queue();
  this.q.concurrency = 1;

  var options = {
    player: "aplay",
    device: "default:Device"
  }

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
        this.motor.stop();
        this.player.stop();
    }

    this.run = function() {
       this.q.start(function(err) {
          if (err != null) {
            console.log(err);
          }
	    });
    }

    this.doMovement = function(action,timeout) {
        this.speak();        
        this.doSound(action);
   }

   this.speak = function() {
        //Move the motor between two positions until audio stops playing
/*
0 to 30
ears up, eyes open, mouth closed, not tilted
170 to 200
ears up, eyes open, mouth open, not tilted
*/
        if (this.playing) {
        var self = this;
        this.motor.goto(15);
        console.log("Goto15");
        setTimeout(function() {
            self.motor.goto(185);
            console.log("Goto185");
            setTimeout(function() { self.speak();
                },500 );
            },500 );
        }
   }

   this.doSound = function(action) {
       //Could simplify this with a lookup table
        this.playing = true;
        switch (action) {
            case "START": {
                if (Math.random() > 0.5) {
                    this.player.play("./audio/EngineStarting.wav");
                } else {
                    this.player.play("./audio/LetsGo.wav");
                }
                break;
            }
            case "FORWARD": {
                if (Math.random() > 0.5) {
                    this.player.play("./audio/Forward.wav");
                } else {
                    this.player.play("./audio/Whee.wav");
                }
                break;
            }
            case "LEFT": {
                this.player.play("./audio/GoLeft.wav");
                break;
            }
            case "RIGHT": {
                this.player.play("./audio/GoRight.wav");
                break;
            }   
            case "REVERSE": {
                this.player.play("./audio/GoRight.wav");
                break;
            }     
            case "BUMP": {
                if (Math.random() > 0.5) {
                    this.player.play("./audio/Bump.wav");
                } else {
                    this.player.play("./audio/Oops.wav");
                }
            }    
            case "SHUTDOWN": {
                if (Math.random() > 0.5) {
                    this.player.play("./audio/NighNight.wav");
                } else {
                    this.player.play("./audio/Yawn.wav");
                }
            }                      
        default:  
             break; //Nothing matches
        }
   }
}

module.exports = new controller();
