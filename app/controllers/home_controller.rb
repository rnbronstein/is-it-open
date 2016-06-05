class HomeController <ApplicationController

  def index
    # Adapters
    # - Connect to Google Places.
    g_places_api = Adapter::GooglePlacesWrapper.new

    g_places_api.run_search
    # Create a venue object
    # -services for the Venue Model for extracting the fields we want.
  end
end
