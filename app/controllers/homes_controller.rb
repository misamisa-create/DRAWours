class HomesController < ApplicationController
  def top
    # @posts = Post.limit(5)
    # N+1
    @posts = Post.includes(:user).limit(5).with_attached_image
  end
end
