module.exports = function (RED) {
   function buildMsgNode(config) {
      RED.nodes.createNode(this, config);
      var node = this;
      var context = this.context();
      var globalContext = this.context().global;
      this.on('input', function (msg) {
         var device = config.gateway;
         if (device.trim().length == 0) {
            device = globalContext.get("DEFAULT_EDGE_CONTROLLER");
         }
         if (device) {
            device = device.toLowerCase();
         }
         var address = config.address;
         if (address.trim().length == 0) {
            address = msg.topic;
         }
         address = address.toLowerCase();
         var msgtype = config.msgtype.toLowerCase();
         var porttype = config.porttype.toLowerCase();
         if ((!device) || (device.trim().length == 0)) {
            node.warn("Edge Controller not defined. Did you set a default one?");
            node.send(null);
            return;
         }
         if ((!address) || (address.trim().length == 0)) {
            node.warn("Address not defined");
            node.send(null);
            return;
         }
         if (msgtype.trim().length == 0) {
            node.warn("Msg Type not defined");
            node.send(null);
            return;
         }
         if (porttype.trim().length == 0) {
            node.warn("Port Type not defined");
            node.send(null);
            return;
         }
         var topic = 'rpdlite/' + device + '/' + msgtype + '/' + porttype + '/' + address;
         var payload = {
            device: device,
            type: porttype,
            address: address,
            value: msg.payload
         };
         msg.topic = topic;
         msg.payload = payload;
         node.send(msg)
      });
   }
   RED.nodes.registerType("build-msg", buildMsgNode);
}
