App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    //checks if user is just typing or sending a message.
    // if user still typing then show the typing... label to ther other user so the other person knows that other person is typing..
    if (data.typing !== null && data.user_id !== parseInt(document.getElementById('user-id').innerHTML)){
      if (data.typing === "true"){
        $(".typing-text").remove();
        $('#messages').append ("<typing-text class='typing-text'>" + "Typing.... " + "</br>" + "</br>" + "</typing-text>")
        var objDiv;
        objDiv = document.getElementsByClassName('message_content_div')[0];
        objDiv.scrollTop = objDiv.scrollHeight;
      }else{
        $(".typing-text").remove();
      }
    }
    //if he click send and the message is send then this method runs and send message.
    // checks if current user is the messag esender then show a different style message else show different stle message and scroll to the bottom of div.
    if (data.typing === undefined){
      if (data.user_id === parseInt(document.getElementById('user-id').innerHTML)){
        $('#messages').append ("<p style='text-align: right;text-align: right;background: rgba(0, 128, 128, 0.38);padding: 10px;border-radius: 6px;'>" + data.content +  "</br>" + "<created_at style='font-size:12px;'>" + data.created_at + "</created_at>" + "</p>");
      }else{
        $('#messages').append ("<p style='float:lefttext-align: right;background: rgba(245, 222, 179, 0.51);padding: 10px;border-radius: 6px;'>" + data.content + "</br>" + "<created_at style='font-size:12px;'>" + data.created_at + "</created_at>" + "</p>");
      }
      var objDiv;
      objDiv = document.getElementsByClassName('message_content_div')[0];
      objDiv.scrollTop = objDiv.scrollHeight;
    };
  },

  speak: function(message) {
    this.perform('speak', {
      message: message
    });
  }
});
