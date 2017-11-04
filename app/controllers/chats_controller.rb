class ChatsController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user.present?
      @all_users = User.where.not(id: current_user.id)
      @user_chats = current_user.chats.uniq
    else
      redirect_to new_user_session_path
    end
  end

  def create
    recipient = User.find(params[:id])
    # if current_user.chats.joins(:subscribers).where(subscribers: {user_id: recipient.id}).present?
    chat = Chat.create()
    Subscriber.create(user_id: current_user.id, chat_id: chat.id)
    Subscriber.create(user_id: recipient.id, chat_id: chat.id)
    redirect_to chats_path
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages
  end
end
