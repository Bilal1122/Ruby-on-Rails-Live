$ ->
  $(document).ready ->
    if document.getElementsByClassName('message_content_div')[0] != undefined
      objDiv = document.getElementsByClassName('message_content_div')[0]
      objDiv.scrollTop = objDiv.scrollHeight

    setTimeout (->

      app = this.App
      subscriber_id = parseInt(document.getElementById('subscriber-id').innerHTML)

      $('#create_msg').on 'click', (evt, message_content)->
        message_content = document.getElementById('send_msg_content')
        if message_content.value != ""
          app.room.speak(content: message_content.value, subscriber_id: subscriber_id)
          message_content.value = null
        else
          alert("Blank Message Alert!")
        evt.preventDefault()
        

      $('#send_msg_content').on 'input', (evt)->
        setTimeout (->
          typing = "false"
          message_content = document.getElementById('send_msg_content').value
          if message_content != ""
            typing = "true"
          app.room.speak(typing: typing, subscriber_id: subscriber_id)
        ), 10
    ), 10