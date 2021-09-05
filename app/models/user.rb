class User < ApplicationRecord
  has_one_attached :icon_image
  has_one_attached :header_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 中間テーブルのアソシエーションを入れる
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
