module ApplicationHelper
  # 投稿に含まれるURLをリンク化する
  # text_url_to_link(h(@user.url)).html_safeなでこのメソッドを呼び出せる
  require "uri"

  def text_url_to_link text

    URI.extract(text, ['http','https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      text.gsub!(url, sub_text)
    end

    return text
  end
end
