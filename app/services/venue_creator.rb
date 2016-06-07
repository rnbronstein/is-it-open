class VenueCreator
  def initialize(venue)
    @venue_data = venue
    @details_client = build_details_client(venue)
  end

  def get_venue_details
    venue_details = @details_client.details_call['result']

    if(venue_details['opening_hours'] && venue_details['photos'])
      Venue.new(formatted_address: venue_details['formatted_address'],
        formatted_phone_number: venue_details['formatted_phone_number'],
        name: venue_details['name'],
        opening_hours: venue_details['opening_hours']['periods'],
        photo: venue_details['photos'].first['photo_reference']
      )
    end
  end

  def get_reduced_venue_details
    if(@venue_data['photos'] && @venue_data['opening_hours']['open_now'])
      Venue.new(formatted_address: @venue_data['vicinity'],
      name: @venue_data['name'], open_now: @venue_data['opening_hours']['open_now'],
      photo: @venue_data['photos'].first['photo_reference'])
    end
  end

  private

  def build_details_client(venue)
    Adapter::PlaceDetailsWrapper.new(venue['place_id'])
  end
end
