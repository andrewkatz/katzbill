class BillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bill_from_params, only: [:pay, :paid]

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
    unless @bill.pay_url.present?
      redirect_to action: :paid, id: params[:bill_id]
    end
  end

  def paid
    @bill.pay!

    redirect_to action: :index
  end

  private

  def set_bill_from_params
    @bill = current_user.bills.where(id: params[:bill_id]).first!
  end

  def bill_params
    params.require(:bill).permit(:id, :name, :due_date, :pay_url)
  end
end
