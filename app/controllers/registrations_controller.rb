class RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up_params
    params.permit(user: %i(email password password_confirmation invite_token))[:user]
  end

  def account_update_params
    params.permit(
      user: %i(
        email
        password
        password_confirmation
        current_password
        pushover_user_key
        notify_email
        notify_sms
        notify_push
        phone
      )
    )[:user]
  end
end
