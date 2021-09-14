class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    # redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    # Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    # redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
