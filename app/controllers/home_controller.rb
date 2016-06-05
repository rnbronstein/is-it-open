class HomeController <ApplicationController
  before_action :set_location, only: :index

  def index
    # Adapters
    # - Connect to Google Places.
    g_places_api = Adapter::GooglePlacesWrapper.new

    g_places_api.run_search
    # Create a venue object
    # -services for the Venue Model for extracting the fields we want.
  end

  private

  def set_location
    client_ip = remote_ip()
    @latitude = client_ip.latitude
    @longitude = client_ip.longitude
  end

end
