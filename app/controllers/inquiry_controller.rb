class InquiryController < ApplicationController
  # 問い合わせ画面
  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  # 問い合わせ確認画面
  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  # 問い合わせ完了通知画面
  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))    
    InquiryMailer.received_email(@inquiry).deliver

    # 完了画面を表示
    render :action => 'thanks'
  end
end
