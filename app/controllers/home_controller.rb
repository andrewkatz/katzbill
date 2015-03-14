class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.payments.order(:next_pay_date)
  end
end
