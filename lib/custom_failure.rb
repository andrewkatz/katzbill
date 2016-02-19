class CustomFailure < Devise::FailureApp
  def respond
    if request.xhr?
      http_auth
    else
      super
    end
  end
end
