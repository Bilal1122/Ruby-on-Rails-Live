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
    response = ChatCreationService.new(current_user, recipient).call
    redirect_to chat_path(response[:chat_id])
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
  end

  def chat_link
    redirect_to chat_path(params[:chat_id])
  end
end
