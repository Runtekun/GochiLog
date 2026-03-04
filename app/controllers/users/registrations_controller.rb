# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    reviews_path
  end

end
