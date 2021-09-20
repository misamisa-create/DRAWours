class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  # デバイス機能
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    posts_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name, :icon_image, :header_image, :introduction, :url])
  end
end
