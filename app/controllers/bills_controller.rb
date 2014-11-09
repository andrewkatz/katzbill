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
    bill = Bill.find(params[:bill_id])
    bill.pay!

    redirect_to action: :index
  end

  private

  def bill_params
    params.require(:bill).permit(:id, :name, :due_date)
  end
end
