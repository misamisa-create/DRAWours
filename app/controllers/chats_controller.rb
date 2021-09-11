class ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show]

  def show
    @user = User.find(params[:id])
    chat_rooms = current_user.user_rooms.pluck(:chat_room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, chat_room_id: chat_rooms)

    unless user_rooms.nil?
      @chat_room = user_rooms.chat_room
    else
      @chat_room = ChatRoom.new
      @chat_room.save
      UserRoom.create(user_id: current_user.id, chat_room_id: @chat_room.id)
      UserRoom.create(user_id: @user.id, chat_room_id: @chat_room.id)
    end
    @chat_messages = @chat_room.chat_messages
    @chat_message = ChatMessage.new(chat_room_id: @chat_room.id)

  end

  def create
    @chat_messages = current_user.chat_messages.new(chat_message_params)
    @chat_messages.save
  end

  private
  def chat_message_params
    params.require(:chat_message).permit(:message,:chat_room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end



end
