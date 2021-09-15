class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    # 未確認の通知を取り出す
    @notifications.where(checked: false).each do |notification|
      # 確認済みに更新
      notification.update_attributes(checked: true)
    end
    
  end
end
