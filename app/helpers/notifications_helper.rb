module NotificationsHelper
  # 未確認の通知を検索するメソッド
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  # viewページでnotification_form(notification)を入れるとこれらに移る
  # 通知内容を定義している
  def notification_form(notification)
    # 反応した相手の情報
    @visitor = notification.visitor
    @comment = nil
    @post = link_to 'あなたの投稿', post_path(notification), style: "font-weight: bold;"
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "follow"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "があなたをフォローしました"
    when "like"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にいいねしました"
    when "comment" then
      # コメントのidとテキストカラム（内容）を取り出す
      @comment = Comment.find_by(id: notification.comment_id)&.text
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    end
  end
end
