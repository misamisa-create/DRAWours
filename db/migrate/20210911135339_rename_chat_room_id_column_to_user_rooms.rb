class RenameChatRoomIdColumnToUserRooms < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_rooms, :chat_room_id, :room_id
  end
end
