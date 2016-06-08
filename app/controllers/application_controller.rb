class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :get_venue_photo_reference

  def set_ip
    #sets a remote IP for development; can remove this method in production and just call request.ip
    # if request.ip == '127.0.0.1' || request.ip == "::1" ==> if having problems in development, uncomment me!
    #   '96.246.147.107'
    # else
    #   request.ip
    # end
    request.ip
  end

  def get_venue_photo_reference(venue)
    VenueDecorator.new(venue).photo_reference_url
  end
end
