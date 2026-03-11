# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update, :edit ]

  protected

  # nameカラムをユーザー登録の際に許可
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  # name, bio, avatarカラムをユーザー更新の際に許可
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :bio, :avatar ])
  end

  # ユーザーがプロフィールを更新する際に、現在のパスワードを要求しないようにするためのメソッド
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    reviews_path
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
