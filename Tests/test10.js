//Test with the MiniBreakout

var mraa = require('mraa'); 
console.log('MRAA Version: ' + mraa.getVersion()); 

var pin8 = new mraa.Gpio(8);
var pin9 = new mraa.Gpio(9);

pin8.dir(mraa.DIR_IN);
pin9.dir(mraa.DIR_IN);

pin8.isr(mraa.EDGE_RISING, function () {
	console.log("Edge8");
});

pin9.isr(mraa.EDGE_RISING, function () {
	console.log("Edge9");
});


setInterval(function () {} , 1000); //Do nothing, stops the apps exiting

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    pin8.isrExit();
    pin9.isrExit();
    process.exit();
});


