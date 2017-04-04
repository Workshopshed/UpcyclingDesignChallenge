#!/usr/bin/env node

// Listens for messages on a queue and responds

var mqtt = require('mqtt');

var controller = require('./carController.js');

console.log('Starting Car Listener');

console.log('Connecting to Queue');

var options = {
  port:1884,
  rejectUnauthorized: false,
  protocol: 'wss'
}

var client = mqtt.connect('mqtts://localhost', options);

client.on('connect', function () {
    console.log('Connected');
    client.subscribe('E14_UCDC/+/Commands')
})

client.on('error', function (errMess) {
    console.log(errMess);
})

client.on('close', function () {
    console.log('Closed');
})

client.on('message', function (topic, message) {
    var command = JSON.parse(message.toString());
    controller.addMovement(command);
    console.log(message.toString());
})

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    controller.shutdown();
    client.end()
    process.exit();
})

function doStuff() {
    console.log("Heartbeat...");
};

function run() {
    console.log('Running')
    setInterval(doStuff, 30000);
};

run();

