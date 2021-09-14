class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # うまくかけられない
  validates :message, presence: true
  # validates :message, presence: true, on: :save


end



