# frozen_string_literal: true

class CustomSessionsController < Devise::SessionsController
  # DELETE /resource/sign_out
  def destroy
    UserActivity.create(user_id: current_user.id, action: 'logout', logout_time: Time.now.utc)

    super
  end
end
