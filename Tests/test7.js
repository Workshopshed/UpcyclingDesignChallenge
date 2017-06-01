var m;
 
m = require('mraa');

//For real mcu we'd create a stream duplex to the correct file location
var mcu = require("./mockMCU.js");
var mcu1 = new mcu();

var motor = require('./motor.js');

var m1 = new motor(1,2,3,4,5,mcu1);

m1.Reset();

var timer = setInterval(function () {
    console.log("Counter: %s",m1.Position());
}, 50);

//Wait for reset to complete. Perhaps a promose might be a better approach.
setTimeout(function() {

console.log (m1.Distance(100));
console.log (m1.Direction(100));
console.log (m1.Max());
m1.Speed(10);
m1.Goto(100);

setTimeout(function() {
    console.log ("Current Position: %d",m1.Position());
    console.log (m1.Distance(100));
    console.log("Stopping");
    m1.Stop();
    clearInterval(timer);
},5000);

 },1100);

