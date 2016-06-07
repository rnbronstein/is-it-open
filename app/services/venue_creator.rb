class VenueCreator
  def get_venue_expanded_details
    @details_client = build_details_client(@venue_data)
    @venue = Venue.find_by(place_id: @venue_data['place_id'])

    venue_details = @details_client.details_call['result']

    if venue_details['formatted_phone_number']
      @venue[:formatted_phone_number] = venue_details['formatted_phone_number']
    end

    if venue_details['opening_hours']['periods']
      @venue[:opening_hours] = venue_details['opening_hours']['periods']
    end

  end

  def get_reduced_venue_details(venue_data)
    @venue_data = venue_data
    if(@venue_data['photos'] && @venue_data['opening_hours'])
      Venue.new(formatted_address: @venue_data['vicinity'],
      name: @venue_data['name'], open_now: @venue_data['opening_hours']['open_now'],
      photo: @venue_data['photos'].first['photo_reference'])
    end
  end

  private

  def build_details_client(venue_data)
    Adapter::PlaceDetailsWrapper.new(venue_data['place_id'])
  end
end
