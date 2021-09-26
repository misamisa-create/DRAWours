class HomesController < ApplicationController
  def top
    # @posts = Post.limit(5)
    @posts = Post.limit(5).with_attached_image
  end
end
