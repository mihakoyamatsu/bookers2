class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するページ
  def after_sign_in_path_for(resource)
      user_path(resource)
  end

  # ログアウト後に遷移するページ
  def after_sign_out_path_for(resource)
      root_path(resource)
  end

  def authenticate_user

  if current_user == nil
     redirect_to new_user_session
  end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end