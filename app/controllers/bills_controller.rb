class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = current_user.bills
  end

  def new
    @bill = current_user.account.bills.build
  end

  def create
    @bill = current_user.account.bills.build(bill_params)

    while @bill.due_date < Date.current
      @bill.pay
    end

    if @bill.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def pay
    bill = current_user.bills.find(params[:id])
    bill.pay!

    redirect_to action: :index
  end

  def destroy
    bill = current_user.bills.find(params[:id])
    bill.destroy

    redirect_to bills_path
  end

  private

  def bill_params
    params.require(:bill).permit(:id, :name, :due_date, :pay_url)
  end
end
