class Relationship < ApplicationRecord
  # 中間テーブルのアソシエーション
  # follower_idカラムの値からusersテーブルのレコードを参照できるようにする
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # これを記述するとフォローボタンが動かなくなった
  # validates :follower, uniqueness: true
  # validates :followed, uniqueness: true
end
