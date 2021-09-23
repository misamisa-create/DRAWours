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
    @posts = @posts_all.where(user_id: @user).order("created_at DESC").page(params[:page]).per(5)

    # my_rooms_ids = current_user.user_rooms.select(:room_id)
    # @user_rooms = UserRoom.includes(:chats, :user).where(room_id: my_rooms_ids).where.not(user_id: current_user.id).reverse_order
  end

  def update
    @user = User.find(params[:id])
    # if @user.update(user_params)
    # こんな風にバリデーションを無視したい
    @user.assign_attributes(user_params)
    # ユーザのバリデーションを介さない
    if @user.save(validate: false)
      flash[:notice] = 'ユーザ情報を更新しました'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :display_name, :icon_image, :header_image, :introduction, :url)
  end
end
