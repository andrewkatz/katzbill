class HomeController < ApplicationController
  before_action :redirect_if_logged_in

  def index
  end

  private

  def redirect_if_logged_in
    redirect_to dashboard_path if user_signed_in?
  end
end
