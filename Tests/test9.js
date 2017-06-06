var fs = require('fs');

var mcuR = fs.createReadStream('/dev/ttymcu0');
var mcuW = fs.createWriteStream('/dev/ttymcu0');
var debug = fs.createReadStream('/dev/ttymcu1');

debug.on('data', function(data) {
   console.log("Debug:%s",data.toString());
    });

mcuR.on('data', function(data) {
   console.log(data.toString());
    });

setTimeout(function() {mcuW.write('M\n'); },50);
setTimeout(function() {mcuW.write('U\n'); },100);
setTimeout(function() {mcuW.write('D\n'); },200);
setTimeout(function() {mcuW.write('C\n'); },500);



