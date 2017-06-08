// With full options 
var soundplayer = require("sound-player");
var options = {
    filename: "LetsGo.wav",
    player: "aplay",
    device: "default:Device"
}

//var spawn = require('child_process').spawn;
//Set volume
//spawn('pactl',['set-sink-volume','0','30%']);

console.log("Play");
var player = new soundplayer(options)
player.play();
console.log("Ready");

player.on('complete', function() {
    console.log('Done with playback!');
});

player.on('error', function(err) {
    console.log('Error occurred:', err);
});
