var m;
 
m = require('mraa');

var motor = require('./motor.js');

var m1 = new motor(1,2,3,4,5);

m1.Forward();
m1.Speed(10);
m1.Stop();