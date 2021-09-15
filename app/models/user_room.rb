class UserRoom < ApplicationRecord
  # usersテーブルとroomsテーブルの中間テーブル
  belongs_to :user
  belongs_to :room
end
