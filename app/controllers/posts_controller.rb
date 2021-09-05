class PostsController < ApplicationController
  def index

    @posts = Post.all

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
