class RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up_params
    params.permit(user: [:email, :password, :password_confirmation, :invite_token])[:user]
  end

  def account_update_params
    params.permit(
      user: [:email, :password, :password_confirmation, :current_password, :pushover_user_key]
    )[:user]
  end
end
