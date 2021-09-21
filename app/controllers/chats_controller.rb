class ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show]

  def show
    # Bさんのユーザー情報を取得
    @user = User.find(params[:id])
    # user_roomsテーブルのuser_idがAのレコードのroom_idを配列で取得
    # この時点でBと関連づけてないためただAが持っているroom_idということになる
    rooms = current_user.user_rooms.pluck(:room_id)
    # user_idがBで、room_idがAの属するroom_idとなるuser_roomテーブルのレコードを取得して、user_room変数に格納
    # AとBが属するroomを取得できるが、なぜ複数になる？
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # もしuser_roomsが既に作られていたら
    if user_rooms.nil?
      @room = Room.new
      @room.save
      # 採番したroomのidを使って、user_roomのレコードを2人分(A,B)作る(=A.B共通のroom_idを作る)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      # user_roomに紐づくroomsテーブルのレコードを取得
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    # Aのchat内容を新規取得
    @chat = current_user.chats.new(chat_params)
    room = Room.find(chat_params[:room_id])
    @chat.save
    @chats = room.chats
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id, :user_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end
end
