
var mraa = require('mraa');
var events = require('events');

var listner1 = function listner1(value) {
   console.log('Bumper:%d' , value);
}

var eventEmitter = new events.EventEmitter();
eventEmitter.addListener('bumper', listner1);

var previous = -1;
var analogPin0 = new mraa.Aio(1); //setup access analog input pin 0

//Monitor the bumper analogue pin and raise events if it changes
setInterval(function () {
    var analogValueFloat = analogPin0.readFloat();
    //console.log(analogValueFloat );
    var newval = floatToSwitch(analogValueFloat)
    if (newval != previous) {
        eventEmitter.emit('bumper',newval);
        previous = newval;
    }
} , 100);

var BumpEnum = {
  None: 0,
  Left: 1,
  Right: 2,
  Both: 3
};

//Scale the input to one of our 4 values depending on
//which of the two switches are pressed
function floatToSwitch(value) {
    if (value < 0.1) return BumpEnum.None;
    if (value < 0.25) return BumpEnum.Left;
    if (value < 0.38) return BumpEnum.Right;
    if (value >= 0.38) return BumpEnum.Both;
}


process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    process.exit();
});
