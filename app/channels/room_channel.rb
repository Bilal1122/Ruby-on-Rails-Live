class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # binding.pry
    subscriber = Subscriber.find(data['message']['subscriber_id'])
    if !data['message']['typing'].present?
      message = Message.create(content: data['message']['content'], subscriber_id: subscriber.id)
      ActionCable.server.broadcast 'room_channel', {content: data['message']['content'], user_id: subscriber.user_id, created_at: message.created_at.strftime("%a %e %b %l:%M %p")}
    else
      ActionCable.server.broadcast 'room_channel', {typing: data['message']['typing'], user_id: subscriber.user_id}
    end
  end
end