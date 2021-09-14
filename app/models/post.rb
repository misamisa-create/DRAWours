class Post < ApplicationRecord
  # タグ機能
  acts_as_taggable
  # 一旦外部キーのnilを許可
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

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
