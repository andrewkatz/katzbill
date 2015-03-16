class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:pay, :destroy, :edit, :update]

  def new
    @payment = current_user.account.payments.build(type: params[:type].classify)
    @form_url = payments_path

    render :form
  end

  def create
    @payment = current_user.account.payments.build(payment_params)
    @payment.update_next_pay_date

    if @payment.save
      redirect_to root_path
    else
      render :form
    end
  end

  def pay
    @payment.pay!

    redirect_to root_path
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

    if @payment.save
      redirect_to root_path
    else
      render :form
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:id, :name, :due_on, :url, :type, :allow_weekends)
  end

  def set_payment
    @payment = current_user.payments.find(params[:id])
  end
end
