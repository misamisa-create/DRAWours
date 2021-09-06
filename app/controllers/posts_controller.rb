class PostsController < ApplicationController
  def index
    # N+1問題を防ぐためのincludesメソッド
    # あとでfavoriteなども追加していく
    @posts_all = Post.includes(:user)
    @user = User.find(current_user.id)
    # フォローしているユーザーを取得
    follow_users = current_user.followings
    # 自分の投稿も表示されるようにする
    follow_users.push(@current_user)
    # フォローユーザの投稿を取得
    @posts = @posts_all.where(user_id: follow_users).order("created_at DESC")

  end

  def new
    @post = Post.new
  end



  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title,:text,:image,:making_time,:instrument,:genre)
  end
end
