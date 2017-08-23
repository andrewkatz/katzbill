class HomeController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  before_action :redirect_if_logged_in

  def index
  end

  private

  def redirect_if_logged_in
    redirect_to dashboard_path if user_signed_in?
  end
end
