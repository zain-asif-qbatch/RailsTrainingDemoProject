import consumer from "./consumer"

consumer.subscriptions.create("ReactsChannel", {

  connected() {
   console.log("Connected to Reacts")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Recieved to Reacts")
    // Called when there's incoming data on the websocket for this channel
    $("#reacts_" + data['reactable_type'] + "_" + data['reactable_id'] + ":first").replaceWith(data['reactable']);
  },
});

