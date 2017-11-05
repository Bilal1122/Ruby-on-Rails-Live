class ChatCreationService

  def initialize(current_user, recipient)
    @current_user = User.find(current_user)
    @recipient = recipient
  end

  def call
    if @current_user.chats.present?
      @current_user.chats.each do |chat|
        existing_chat = chat.subscribers.where(user_id: @recipient.id)
        if existing_chat.present?
          chat_id = existing_chat.first.chat_id
        else
          new_chat = create_chat_and_add_recipient
          chat_id = new_chat[:chat_id]
        end
        if chat_id.present? 
          return { chat_id: chat_id, success: true }
          break
        end
      end
    else
      new_chat = create_chat_and_add_recipient
      chat_id = new_chat[:chat_id]
      return { chat_id: chat_id, success: true }
    end
  end

  private

  def create_chat_and_add_recipient
    chat = Chat.create()
    Subscriber.create(user_id: @current_user.id, chat_id: chat.id)
    Subscriber.create(user_id: @recipient.id, chat_id: chat.id)
    return {chat_id: chat.id}
  end
end