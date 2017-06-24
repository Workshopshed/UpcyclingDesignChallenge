#!/usr/bin/env node

"use strict";

var port = 9090,
    http = require('http'),
    url = require('url'),
    fs = require('fs'),
    path = require('path');

var server = http.createServer(servePage);

server.listen(port);
console.log("listening on " + port);

function servePage(req, res) {
    var filePath = url.parse(req.url).pathname;
    console.log("path: " + filePath);

    var extname = path.extname(filePath);
    var contentType = 'text/html';
    switch (extname) {
        case '.js':
            contentType = 'text/javascript';
            break;
        case '.css':
            contentType = 'text/css';
            break;
        case '.json':
            contentType = 'application/json';
            break;
        case '.png':
            contentType = 'image/png';
            break;      
        case '.jpg':
            contentType = 'image/jpg';
            break;
        case '.wav':
            contentType = 'audio/wav';
            break;
    }

    fs.readFile(__dirname + filePath, function (err, data) {
        if (err) {
            return send404(res);
        }
        res.writeHead(200, { 'Content-Type': contentType });
        res.write(data,'utf8');
        res.end();
    });
}

function send404(res) {
    res.writeHead(404);
    res.write('404 - page not found');
    res.end();
}
