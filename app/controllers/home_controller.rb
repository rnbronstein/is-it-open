class HomeController <ApplicationController

  def index
    # Adapters
    # Google Places Client
    @client = Adapter::GooglePlacesWrapper.new

    debugger
    # Create a venue objecte
    # -services for the Venue Model for extracting the fields we want.
  end
end
