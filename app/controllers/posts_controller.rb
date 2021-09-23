class PostsController < ApplicationController
  def index
    # 検索時に使用
    @all_posts = Post.all
    # 週間いいねランキング
    @week_post_like_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(4).pluck(:post_id))
    @tags = ActsAsTaggableOn::Tag.all
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
    # タイムラインの投稿を取得
    @posts = @posts_all.where(user_id: follow_users_ids).order("created_at DESC").page(params[:page]).per(5)
    # タグの一覧表示
    if params[:tag]
      # タグ付けしている投稿を取得
      @posts = @posts_all.order("created_at DESC").tagged_with(params[:tag])
    end
  end

  def new
    @post = Post.new
    @tags = ActsAsTaggableOn::Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿に成功しました'
      redirect_to posts_path
    else
      @tags = ActsAsTaggableOn::Tag.all
      render :new
    end
  end

  def show
    @tags = ActsAsTaggableOn::Tag.all
    # コメント機能
    @comment = Comment.new
    if params[:tag]
      # フォローユーザの投稿を取得
      @post = Post.find(params[:id]).tagged_with(params[:tag])
    else
      @post = Post.find(params[:id])
    end
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = '投稿を削除しました'
        redirect_to request.referer
      else
        @tags = ActsAsTaggableOn::Tag.all
        render :show
      end
    end
  end

  private

  def post_params
    # tag_listを追加
    params.require(:post).permit(:title, :text, :image, :making_time, :instrument, tag_list: [])
  end
end
