class ChangeChatRoomUsersToUserRooms < ActiveRecord::Migration[5.2]
  def change
    rename_table :chat_room_users, :user_rooms
  end
end
