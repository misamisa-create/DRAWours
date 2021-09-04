class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy

  # ジャンルを選択できるようにしたい
end
