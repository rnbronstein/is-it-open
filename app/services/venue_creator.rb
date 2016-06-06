class VenueCreator

  def initialize(client)
    @search_client = client
  end

  def get_venue_details

  end

  def get_venues
    venues = []

    @search_client.default_call()['results'].each do |venue|
      details_client = place_details_client(venue)
      venues << @details_client.details_call #returns a JSON element { name: "Spock's restaurant", }
    end

    venues
  end

  def details_client(venue)
    Adapter::PlaceDetailsWrapper.new(venue['place_id'])
  end
end




def place_details_client(venue)
  @details_client = Adapter::PlaceDetailsWrapper.new(venue['place_id'])
end
