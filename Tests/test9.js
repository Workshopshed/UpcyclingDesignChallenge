var stream = require('stream');
var util = require('util');
var fileduplex = require('file-duplex');

var mcu = new fileduplex('/dev/ttymcu0');


