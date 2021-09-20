class Notification < ApplicationRecord
  # デフォルトの並び順を作成日時の降順にしている(新しい通知からデータを取得できる)
  default_scope -> { order(created_at: :desc) }
  # optional: trueでnilを許可している
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  # userとの紐付け
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
