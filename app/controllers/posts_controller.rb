class PostsController < ApplicationController
  def index
    # N+1問題を防ぐためのincludesメソッド
    # あとでfavoriteなども追加していく
    @posts_all = Post.includes(:user)
    @user = User.find(current_user.id)
    # フォローしているユーザーを取得
    follow_users = @user.followings
    # follow_users = [@user.followings, @user]
    # 自分の投稿も表示されるようになるが、今後userに自分が含まれてしまうので絶対にやらない！
    # follow_users.push(@current_user)
    # フォローユーザの投稿を取得
    @posts = @posts_all.where(user_id: follow_users).order("created_at DESC")
    # @posts = @posts_all.where(user_id: [follow_users,@user]).order("created_at DESC")
    # @posts = @posts_all.where(user_id: [follow_users]).order("created_at DESC")


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
    @post = Post.find(params[:id])

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
