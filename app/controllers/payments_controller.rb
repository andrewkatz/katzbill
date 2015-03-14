class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @payment = current_user.account.payments.build(type: params[:type].classify)
  end

  def create
    @payment = current_user.account.payments.build(payment_params)
    @payment.update_next_pay_date

    if @payment.save
      redirect_to root_path
    else
      render :new
    end
  end

  def pay
    payment = current_user.payments.find(params[:id])
    payment.pay!

    redirect_to root_path
  end

  def destroy
    payment = current_user.payments.find(params[:id])
    payment.destroy

    redirect_to root_path
  end

  private

  def payment_params
    params.require(:payment).permit(:id, :name, :due_on, :url, :type)
  end
end
