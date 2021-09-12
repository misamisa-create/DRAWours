class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    # 最終的な検索結果
    @records = search_for(@model,@content,@method)
  end

  private
  def search_for(model,content,method)
    if model == 'user'
      if method == "match"
        User.where(name: content)
      elsif method == "forward"
        User.where("name LIKE ?", "#{content}%")
      elsif method == "backward"
        User.where("name LIKE ?", "%#{content}")
      else
        User.where("name LIKE ?", "%#{content}%")
      end
    elsif model == 'post'
      if method == "match"
        Post.where(title: value)
      elsif method == "forward"
        Post.where("title LIKE ?", "#{content}%")
      elsif method == "backward"
        Post.where("title LIKE ?", "%#{content}")
      else
        Post.where("title LIKE ?", "%#{content}%")
      end
    end

  end
end


