//Test Furby Motor with the MiniBreakout / Outputs
var motor = require('./motorFurby.js');
var fs = require('fs');

var mcuR = fs.createReadStream('/dev/ttymcu0');
var mcuW = fs.createWriteStream('/dev/ttymcu0');

var debug = fs.createReadStream('/dev/ttymcu1');

debug.on('data', function(data) {
   console.log("Debug:%s",data.toString());
});

var m = new motor (19, 20, 21, 9, 8, mcuW, mcuR);

m.Speed(0.8);
m.Reset();

//Todo: Ensure that the one revolution timeout is configured correctly
setTimeout(function() {m.Goto(100); },5000);
setTimeout(function() {m.Goto(150); },10000);
setTimeout(function() {m.Goto(200); },15000);
setTimeout(function() {m.Goto(50);  },20000);
