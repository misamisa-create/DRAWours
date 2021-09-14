class User < ApplicationRecord
  # activerecord導入のためのメソッド
  has_one_attached :icon_image
  has_one_attached :header_image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # アソシエーションはこちら
  has_many :user_rooms
  has_many :chats
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
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

  validates :email, presence: true
  validates :password, presence: true,length: { minimum: 6 }
  validates :name, presence: true,length: { in: 1..50 }
  validates :display_name, presence: true,length: { in: 1..50 }
  validates :introduction, length: { maximum: 200 }

  # ひとまずアイコンのバリデーションはできたが、ヘッダーはどう記述すればよいのか？
  validate :icon_image_type, if: :attached_icon_image?
  validate :header_image_type, if: :attached_header_image?


  def icon_image_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:icon_image, "の拡張子が間違っています") unless icon_image.content_type.in?(extension)
  end

  def attached_icon_image?
    self.icon_image.attached?
  end

  def header_image_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:header_image, "の拡張子が間違っています") unless header_image.content_type.in?(extension)
  end

  def attached_header_image?
    self.header_image.attached?
  end

end
