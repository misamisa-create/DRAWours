class User < ApplicationRecord
  has_one_attached :icon_image
  has_one_attached :header_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 自分がフォローされる側の関係性(被フォロー)
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする側の関係性(与フォロー)
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通して自分をフォローしている人を参照
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通して自分がフォローしている人を参照
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # アイコン・ヘッダーデフォルト画像を用意

  has_many :chat_room_users, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validate :image_type

  private

  def image_type
    if !icon_image.blob.content_type.in?(%('icon_image/jpeg icon_image/png'))
      icon_image.purge # Rails6では、この1行は必要ない
      errors.add(:icon_image, 'はJPEG/PNG形式を選択してアップロードしてください')
    end
    if !header_image.blob.content_type.in?(%('header_image/jpeg header_image/png'))
      header_image.purge # Rails6では、この1行は必要ない
      errors.add(:header_image, 'はJPEG/PNG形式を選択してアップロードしてください')
    end
  end


end
