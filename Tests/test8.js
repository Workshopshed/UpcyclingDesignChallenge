//See https://blog.yld.io/2016/01/13/using-streams/

var m = require("./mockMCU.js");
var mcu = new m();
//Test

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

mcu.write("U");
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("D");
mcu.write("M","",function() {console.log("Max: %d",max)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});
mcu.write("C","",function() {console.log(counter)});