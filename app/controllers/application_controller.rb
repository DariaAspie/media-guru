# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, only: [:create, :update], if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = %i[username email password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def after_sign_in_path_for(resource)
    UserActivity.create(user_id: current_user.id, action: 'login', login_time: Time.now.utc)
    root_path
  end

end
