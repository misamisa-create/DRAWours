class UsersController < ApplicationController

  def edit
  end

  def show
    @user = User.find(params[:id])

    # N+1問題を防ぐためのincludesメソッド
    # あとでfavoriteなども追加していく
    @posts_all = Post.includes(:user)
    @user = User.find(current_user.id)
    @posts = @posts_all.where(user_id: @current_user).order("created_at DESC")
  end

  def update
  end
end
