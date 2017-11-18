class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    #Data comes here from the server and is passes to channel/room.js to be brodcasted
    set_incomming_message(data)
    set_subscriber
    if @message['typing'].blank?
      create_message
      broadcast_content = create_broadcast_content_hash(typing: false)
    else
      broadcast_content = create_broadcast_content_hash(typing: true)
    end
    broadcast_contant(broadcast_content)
  end

  private

  def set_incomming_message(data)
    @message = data['message']
  end

  def set_subscriber
    @subscriber = Subscriber.find(@message['subscriber_id'])
  end

  def create_message
    @new_message = Message.create(content: @message['content'], subscriber_id: @subscriber.id)
  end

  def create_broadcast_content_hash(typing:)
    if typing
      {typing: @message['typing'], user_id: @subscriber.user_id}
    else
      {content: @new_message.content, user_id: @subscriber.user_id, created_at: @new_message.created_at.strftime("%a %e %b %l:%M %p")}
    end
  end

  def broadcast_contant(broadcast_content)
    ActionCable.server.broadcast 'room_channel', broadcast_content
  end
end