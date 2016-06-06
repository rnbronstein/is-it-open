class VenueCreator
  def initialize(venue)
    @details_client = build_details_client(venue)
  end

  def get_venue_details
    venue_details = @details_client.details_call['result']

    if(venue_details['opening_hours'] && venue_details['photos'])
      Venue.new(formatted_address: venue_details['formatted_address'],
        formatted_phone_number: venue_details['formatted_phone_number'],
        name: venue_details['name'],
        opening_hours: venue_details['opening_hours']['periods'],
        photos: venue_details['photos'].first['photo_reference']
      )
    end
  end

  private

  def build_details_client(venue)
    Adapter::PlaceDetailsWrapper.new(venue['place_id'])
  end
end
