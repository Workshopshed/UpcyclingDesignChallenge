

function upCycleController() {
    self = this;
    self.clientID = ko.observable("upCycleController" + parseInt(Math.random() * 100, 10));
    self.log = ko.observableArray();
    self.server = 'Eddie.lan';
    self.port = 1884;
    self.status = { name: ko.observable(self.clientID), status: ko.observable("ready") };
    self.Qcommands = "E14_UCDC/" + self.clientID() + "/Commands";

  //Buttons
  self.connect = function() {
    self.client.connect({useSSL:true,onSuccess:self.onConnect, onFailure:self.onConnectFail});}
  self.disconnect = function () {
      self.setstatus("disconnected", true);
      self.client.disconnect();
      self.log.push("Disconnected");
      self.machines.removeAll();
  }

 self.onConnectFail = function(invocationContext,errorCode,errorMessage) {
       console.log(errorCode);
      console.log(errorMessage);
      console.log(invocationContext);
      self.log.push(errorMessage);

  }

  self.newMessage = function(action,timeout) {
       var message = new Paho.MQTT.Message(JSON.stringify({ action: action, timeOut: timeout}));
       message.destinationName = self.Qcommands;
       return message;
  }

  self.left = function () {
      message = this.newMessage("LEFT",1000);
      self.client.send(message);
  }
  self.right = function () {
      message = this.newMessage("RIGHT",1000);
      self.client.send(message);
  }
  self.up = function () {
      message = this.newMessage("FORWARD",1000);
      self.client.send(message);
  }
  self.down = function () {
      message = this.newMessage("REVERSE",1000);
      self.client.send(message);
  }

  self.run = function () {
      message = this.newMessage("RUN",1);
      self.client.send(message);
  }

  self.halt = function () {
      message = this.newMessage("HALT",1);
      self.client.send(message);
  }

  self.setstatus = function (status, retained) {
      self.status.status = status;
      self.log.push("Status: " + status);
  }

  // Create a client instance
  self.client = new Paho.MQTT.Client(self.server,self.port, self.clientID());

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

  self.client.onMessageArrived = function (message) {
          self.log.push(message.destinationName);
          self.log.push(message.payloadString);
         };

  self.onConnect = function() {
      self.setstatus("Connected");
      //Listen to self for logging reasons
      self.client.subscribe("E14_UCDC/+/Commands");
  }

}

ko.applyBindings(new upCycleController());
