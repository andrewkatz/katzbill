class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i(pay destroy edit update show)

  def index
    payments = current_user.account.payments.order(:next_pay_date)

    respond_to do |format|
      format.html
      format.json do
        render json: payments, each_serializer: PaymentSerializer
      end
    end
  end

  def show
    render json: @payment, serializer: PaymentSerializer
  end

  def new
    @payment = current_user.account.payments.build(type: params[:type].classify)
    @form_url = payments_path

    render :form
  end

  def create
    @payment = current_user.account.payments.build(payment_params)
    @payment.update_next_pay_date
    save_payment
  end

  def pay
    @payment.pay!

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json do
        render json: @payment
      end
    end
  end

  def destroy
    @payment.destroy

    redirect_to root_path
  end

  def edit
    @form_url = payment_path(@payment)

    render :form
  end

  def update
    @payment.assign_attributes(payment_params)
    save_payment
  end

  private

  def payment_params
    params.require(:payment).permit(:id, :name, :due_on, :url, :type, :allow_weekends, :autopay)
  end

  def set_payment
    @payment = current_user.payments.find(params[:id])
  end

  def save_payment
    saved = @payment.save
    respond_to do |format|
      format.html do
        if saved
          redirect_to root_path
        else
          render :form
        end
      end
      format.json do
        if saved
          render json: @payment, serializer: PaymentSerializer
        else
          render json: { errors: @payment.errors.full_message }
        end
      end
    end
  end
end
