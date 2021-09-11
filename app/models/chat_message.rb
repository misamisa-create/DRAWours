class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :messages, presence: true, length: { maximum: 140 }
end
