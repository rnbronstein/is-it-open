class VenueLister
  def initialize(ip)
    locator = IpLocator.new(ip)
    @search_client = build_search_client(locator.latitude, locator.longitude)
  end

  def venues_with_details
    venues = []

    @search_client.default_call()['results'].each do |venue|
      details_client = VenueCreator.new(venue)
      venue_details = details_client.get_venue_details
      venues << venue_details if venue_details
    end

    venues
  end

  private

  def build_search_client(latitude, longitude)
    Adapter::GooglePlacesWrapper.new(type: "restaurant",
      latitude: latitude, longitude: longitude)
  end
end
