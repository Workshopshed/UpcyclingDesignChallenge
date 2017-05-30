//See https://blog.yld.io/2016/01/13/using-streams/

//Todo: Integrate this into the motor
var Duplex = require('stream').Duplex;  
var util = require('util');

module.exports = MockMCU;

function MockMCU(options) {  
  if (! (this instanceof MockMCU)) return new MockMCU(options);
  if (! options) options = {};
  options.objectMode = true;
  Duplex.call(this, options);
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
      self.counter += self.direction;
      if (self.counter > self.max) {self.counter = 0;}
      if (self.counter < 0) {self.counter = self.max;}
      self.push("C" + self.counter);
      break;
    }
    case "M": {
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
  }
  setTimeout(callback, 1); //eqivalent of "DoEvents"
};

//Test

var mcu = MockMCU();
var counter = 0;
var max = 0;

mcu.on('data', function(data) {
  switch (data.substring(0,1)) {
   case "C": {
    counter = data.substring(1);
    break;
  }
   case "M": {
    max = data.substring(1);
    break;
  }
  default:  
    console.log("Data recieved %s",data);
  }
});

mcu.on('error', function(error) {  
  console.log('error occurred %s', error);
});

mcu.write("U","",function() {});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("D","",function() {});
mcu.write("M","",function() {console.log("Max: %d",max)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});