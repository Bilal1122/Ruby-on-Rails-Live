$ ->
  $(document).ready ->
    if document.getElementsByClassName('message_content_div')[0] != undefined
      objDiv = document.getElementsByClassName('message_content_div')[0]
      objDiv.scrollTop = objDiv.scrollHeight
      
    $('.view_chat_button').on 'click', (evt)->
      setTimeout (->
        location.reload();
        console.log("ss")
      ), 10

    setTimeout (->
      app = this.App
      $('#create_msg').on 'click', (evt)->
        message_content = document.getElementById('send_msg_content').value
        if message_content != ""
          app.room.speak(content: message_content, subscriber_id: parseInt(document.getElementById('subscriber-id').innerHTML))
          setTimeout (->
            objDiv = document.getElementsByClassName('message_content_div')[0]
            objDiv.scrollTop = objDiv.scrollHeight
          ), 10
          document.getElementById('send_msg_content').value = null
        else
          alert("Blank Message Alert!")
        evt.preventDefault()

      $('#send_msg_content').on 'input', (evt)->
        setTimeout (->
          # console.log(document.getElementById('send_msg_content').value)
          if document.getElementById('send_msg_content').value != ""
            app.room.speak(typing: "true", subscriber_id: parseInt(document.getElementById('subscriber-id').innerHTML))
          else
            app.room.speak(typing: "false", subscriber_id: parseInt(document.getElementById('subscriber-id').innerHTML))
        ), 10
    ), 10