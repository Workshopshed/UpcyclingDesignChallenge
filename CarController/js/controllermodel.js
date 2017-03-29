

function upCycleController() {
    self = this;
    self.clientID = ko.observable("upCycleController" + parseInt(Math.random() * 100, 10));
    self.log = ko.observableArray();
    self.status = { name: ko.observable(self.clientID), status: ko.observable("ready") };
    self.Qcommands = "E14_UCDC/" + self.clientID() + "/Commands";

  //Buttons
  self.connect = function() {
    self.client.connect({onSuccess:self.onConnect});}
  self.disconnect = function () {
      self.setstatus("disconnected", true);
      self.client.disconnect();
      self.log.push("Disconnected");
      self.machines.removeAll();
  }
  self.left = function () {
      message = new Paho.MQTT.Message("LEFT");
      message.destinationName = self.Qcommands;
      self.client.send(message);
  }
  self.right = function () {
      message = new Paho.MQTT.Message("RIGHT");
      message.destinationName = self.Qcommands;
      self.client.send(message);
  }
  self.up = function () {
      message = new Paho.MQTT.Message("UP");
      message.destinationName = self.Qcommands;
      self.client.send(message);
  }
  self.down = function () {
      message = new Paho.MQTT.Message("DOWN");
      message.destinationName = self.Qcommands;
      self.client.send(message);
  }

  self.setstatus = function (status, retained) {
      self.status.status = status;
  }

  // Create a client instance
  self.client = new Paho.MQTT.Client("ws://localhost:1884", self.clientID());

// set callback handlers
  self.client.onConnectionLost = function (responseObject) {
      // called when the client loses its connection
      if (responseObject.errorCode !== 0) {
          self.log.push("onConnectionLost:" + responseObject.errorMessage);
          self.setstatus(responseObject.errorMessage);
      }
  };

  function arrayObjectIndexOf(myArray, searchTerm, property) {
      for (var i = 0, len = myArray.length; i < len; i++) {
          if (myArray[i][property] === searchTerm) return i;
      }
      return -1;
  }

    //This bit would be hosted in the Node.JS service on the board.
      self.client.onMessageArrived = function (message) {
          self.log.push(message.destinationName);
          self.log.push(message.payloadString);
         };

// called when the client connects
  self.onConnect = function() {
      // Once a connection has been made, make a subscription and send a message.
      self.setstatus("Connected");
    self.log.push("Connected");
    // Note that a machine would just connect to run and a monitor would just connect to status.
    self.client.subscribe("E14_UCDC/+/Commands");
  }

}

ko.applyBindings(new upCycleController());
