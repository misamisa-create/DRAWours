class Post < ApplicationRecord
  # activerecord導入のためのメソッド
  has_one_attached :image

  # アソシエーションは
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 画像タイプのバリデーション(下に詳細あり)
  validate :image_type


  # user_idがfavoritesテーブルに存在するか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  private
  def image_type
    if !image.blob.content_type.in?(%('image/jpeg image/png'))
      image.purge # Rails6では、この1行は必要ない
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end


end
