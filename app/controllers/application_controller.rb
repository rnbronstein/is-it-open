class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_ip
    #sets a remote IP for development; can remove this method in production and just call request.ip
    if request.ip == '127.0.0.1' || request.ip == "::1"
      '96.246.147.107'
    else
      request.ip
    end
  end
end
