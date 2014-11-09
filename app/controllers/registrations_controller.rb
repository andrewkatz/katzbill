class RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up_params
    params.permit(user: [:email, :password, :password_confirmation, :invite_token])[:user]
  end
end
