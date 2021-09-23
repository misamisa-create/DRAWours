class HomesController < ApplicationController
  def top
    @posts = Post.all
    # 投稿数が多くなってきたらこれに変えたい
    # @posts = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
end
