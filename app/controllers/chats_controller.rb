class ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show]

  # userコントローラで定義
  # def index
    # my_rooms_ids = current_user.user_rooms.select(:room_id)
    # @user_rooms = UserRoom.includes(:chats, :user).where(room_id: my_rooms_ids).where.not(user_id: current_user.id).reverse_order
  # end

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
    # チャット通知
    @visited_id = params[:chat][:visited_id]
    @room_id = @chat.room

    if @chat.save
      @chats = room.chats
      # チャット通知
      notification = current_user.active_notifications.new(
        room_id: @room_id.id,
        chat_id: @chat.id,
        visited_id: @visited_id,
        visitor_id: current_user.id,
        action: 'chat'
      )
      # 自分の投稿に対するチャットの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      # byebug
      notification.save if notification.valid?
      # redirect_to room_path(chat.room)
    else
      redirect_back(fallback_location: root_path)
    end
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
