class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
end
