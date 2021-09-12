class RenameChatRoomIdColumnToChats < ActiveRecord::Migration[5.2]
  def change
    rename_column :chats, :chat_room_id, :room_id
  end
end
