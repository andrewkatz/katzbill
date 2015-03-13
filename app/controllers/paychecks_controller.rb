class PaychecksController < ApplicationController
  before_action :authenticate_user!

  def new
    @paycheck = current_user.account.paychecks.build
  end

  def create
    @paycheck = current_user.account.paychecks.build(paycheck_params)

    @paycheck.pay while @paycheck.pay_date < Date.current

    if @paycheck.save
      redirect_to root_path
    else
      render :new
    end
  end

  def pay
    paycheck = current_user.paychecks.find(params[:id])
    paycheck.pay!

    redirect_to root_path
  end

  def destroy
    paycheck = current_user.paychecks.find(params[:id])
    paycheck.destroy

    redirect_to root_path
  end

  private

  def paycheck_params
    params.require(:paycheck).permit(:id, :name, :pay_date)
  end
end
