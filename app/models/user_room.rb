class UserRoom < ApplicationRecord
  # usersテーブルとroomsテーブルの中間テーブル
  belongs_to :user
  belongs_to :room
  has_many :chats, through: :room
end
