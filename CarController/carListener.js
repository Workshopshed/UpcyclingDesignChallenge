#!/usr/bin/env node

// Listens for messages on a queue and responds

var mqtt = require('mqtt')

console.log('Starting Car Listener')

console.log('Connecting to Queue')

var client = mqtt.connect('ws://localhost:1884');

client.on('connect', function () {
    client.subscribe('E14_UCDC/+/Commands')
})

client.on('message', function (topic, message) {

    if (topic == 'CAR') {
    	if (message == 'FWD') {
		console.log('Moving Forward')
    }
    console.log(message.toString())
    }
})

process.on('SIGINT', function () {
    console.log("Shutting down SIGINT (Ctrl-C)");
    // some other closing procedures go here
    client.end()
    process.exit();
})

function doStuff() {
    // code to run
    console.log("Heartbeat...");
};

function run() {
    console.log('Running')
    setInterval(doStuff, 30000);
};

run();

