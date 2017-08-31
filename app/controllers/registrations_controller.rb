class RegistrationsController < Devise::RegistrationsController
  PLAN_ID = 'early-bird'.freeze

  def create
    super do
      if sign_up_params[:invite_token].blank? && resource.valid?
        begin
          account = resource.account
          customer = Stripe::Customer.create(
            source: stripe_params[:stripe_token],
            plan: PLAN_ID,
            email: resource.email
          )
          account.update! stripe_customer_id: customer.id
        rescue Stripe::CardError, Stripe::InvalidRequestError => e
          resource.errors.add :credit_card, e.message
        end
      end
    end
  end

  protected

  def stripe_params
    params.permit(:stripe_token)
  end

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
