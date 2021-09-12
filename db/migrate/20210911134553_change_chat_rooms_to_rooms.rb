class ChangeChatRoomsToRooms < ActiveRecord::Migration[5.2]
  def change
    rename_table :chat_rooms, :rooms
  end
end
