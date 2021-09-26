class HomesController < ApplicationController
  def top
    # @posts = Post.limit(5)
    @posts = Post.includes(:user).limit(5)
  end
end
