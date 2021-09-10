class PostsController < ApplicationController
  def index
    # N+1問題を防ぐためのincludesメソッド
    # あとでfavoriteなども追加していく
    @posts_all = Post.includes(:user)
    @user = User.find(current_user.id)
    # pp @user.followings
    # フォローしているユーザーのidを取得
    follow_users_ids = @user.followings.pluck(:id)
    # pp follow_users_ids
    # current_userのidをpush
    # idにしないとcurrent_userがデータごとfollow_userに入ってしまうので注意！
    follow_users_ids.push(current_user.id)
    # フォローユーザの投稿を取得
    @posts = @posts_all.where(user_id: follow_users_ids).order("created_at DESC")


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
    # コメント機能
    @comment = Comment.new

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title,:text,:image,:making_time,:instrument,:genre)
  end
end
