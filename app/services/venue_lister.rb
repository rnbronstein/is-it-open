class VenueLister
  def initialize(location, type) #location will either be a set of coordinates or an IP address; if the former, it's okay to run the locator service on it anyways
    locator = IpLocator.new(location)
    @search_client = build_search_client(locator.latitude, locator.longitude, type)
  end

  def venues_with_reduced_details
    venues = []

    @search_client.call()['results'].each do |venue|
     details_client = VenueCreator.new
      venue_details = details_client.get_reduced_venue_details(venue)
      venues << venue_details if venue_details
    end

    venues
  end

  private

  def build_search_client(latitude, longitude, type)
    Adapter::GooglePlacesWrapper.new(type: type, latitude: latitude,
      longitude: longitude)
  end
end
