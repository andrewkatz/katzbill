class BillsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bill = current_user.account.bills.build
  end

  def create
    @bill = current_user.account.bills.build(bill_params)

    while @bill.due_date < Date.current
      @bill.pay
    end

    if @bill.save
      redirect_to root_path
    else
      render :new
    end
  end

  def pay
    bill = current_user.bills.find(params[:id])
    bill.pay!

    redirect_to root_path
  end

  def destroy
    bill = current_user.bills.find(params[:id])
    bill.destroy

    redirect_to root_path
  end

  private

  def bill_params
    params.require(:bill).permit(:id, :name, :due_date, :pay_url)
  end
end
