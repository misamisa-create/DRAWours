class Post < ApplicationRecord
  # タグ機能
  acts_as_taggable
  # 一旦外部キーのnilを許可
  # activerecord導入のためのメソッド
  has_one_attached :image

  # アソシエーションは
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # user_idがfavoritesテーブルに存在するか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :text,    length: { maximum: 200 }

  # いいね通知の作成メソッド
  def create_notification_like!(current_user)
    # すでにいいねされているか検索
    # ? はプレースホルダというもので、指定した値で置き換え可能
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like' ])
    # いいねされていない場合、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end
  end

  # コメント通知の作成メソッド
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得し、
    # distinctはselectしてから、重複レコードを１つにまとめるメソッド
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    # 全員に通知を送る
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントを複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
  end


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
