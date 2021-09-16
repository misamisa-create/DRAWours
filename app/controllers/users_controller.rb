class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def show
    @tags = ActsAsTaggableOn::Tag.all
    # N+1問題を防ぐためのincludesメソッド
    # あとでfavoriteなども追加していく
    @posts_all = Post.includes(:user)
    @user = User.find(params[:id])

    if params[:tag]
      # フォローユーザの投稿を取得
      @posts = @posts_all.where(user_id: @user).order("created_at DESC").tagged_with(params[:tag])
    else
      @posts = @posts_all.where(user_id: @user).order("created_at DESC")
    end

  end

  def update
    @user = User.find(params[:id])
    # if @user.update(user_params)
      # こんな風にバリデーションを無視したい
    @user.assign_attributes(user_params)
    if @user.save(validate: false)
    # if @user.save :validate => false
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:name,:display_name,:icon_image,:header_image,:introduction,:url)

  end
end
