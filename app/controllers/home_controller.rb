class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = (current_user.bills + current_user.paychecks).sort_by do |item|
      item.try(:due_date) || item.try(:pay_date)
    end
  end
end
