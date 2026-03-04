class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(resource)
    reviews_path
  end

  # nameカラムをユーザー登録の際に許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end
end
