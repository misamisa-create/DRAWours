class AddDetailsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :room_id, :integer
    add_column :notifications, :chat_id, :integer
    add_index :notifications, :room_id
  end
end
