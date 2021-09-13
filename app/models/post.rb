class Post < ApplicationRecord
  # activerecord導入のためのメソッド
  has_one_attached :image

  # アソシエーションは
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # user_idがfavoritesテーブルに存在するか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :text,    length: { maximum: 200 }
  


  # 画像バリデーション
  validate :image_content_type, if: :was_attached?
  validates :image, presence: true

  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:image) unless image.content_type.in?(extension)
  end

  def was_attached?
    self.image.attached?
  end

end
