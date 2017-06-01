var Duplex = require('stream').Duplex;  
var util = require('util');

module.exports = MockMCU;

function MockMCU(options) {  
  if (! (this instanceof MockMCU)) return new MockMCU(options);
  if (! options) options = {};
  options.objectMode = true;
  Duplex.call(this, options);
  var self = this;

  setInterval(function() { 
    self.counter += self.direction;
    if (self.counter > self.max) {self.counter = 0;}
    if (self.counter < 0) {self.counter = self.max;}  
  } , 5)
}

util.inherits(MockMCU, Duplex);

MockMCU.prototype.message = "";
MockMCU.prototype.counter = 0;
MockMCU.prototype.direction = 1;
MockMCU.prototype.max = 208;

MockMCU.prototype._read = function read() {
    //Don't need to do anything here, the write function handled everything
}

MockMCU.prototype._write = function write(command, encoding, callback) {  
  var self = this;
  switch (command.substring(0,1)) {
    case "C": {
      //console.log("Request Count");
      self.push("C" + self.counter);
      break;
    }
    case "M": {
      console.log("Request Max Value");
      self.push("M" + self.max);
      break;
    }
    case "U": {
      console.log("Count Up");
      self.direction = 1;
      break;
    }
    case "D": {
      console.log("Count Down")
      self.direction = -1;
    }
    case "S": {
      console.log("Stop Counting")
      self.direction = 0;
    }
  }
  setTimeout(callback, 1); //eqivalent of "DoEvents"
};
