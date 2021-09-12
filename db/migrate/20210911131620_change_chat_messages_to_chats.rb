class ChangeChatMessagesToChats < ActiveRecord::Migration[5.2]
  def change
    rename_table :chat_messages, :chats
  end
end
