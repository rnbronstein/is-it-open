class VenueCreator
  def get_venue_expanded_details(place_id)
    @details_client = build_details_client(place_id)
    @details_client.details_call['result']
  end

  def get_reduced_venue_details(venue_data)
    @venue_data = venue_data
    if(@venue_data['photos'] && @venue_data['opening_hours'])
      Venue.new(google_place_id: @venue_data['place_id'], formatted_address: @venue_data['vicinity'],
      name: @venue_data['name'], open_now: @venue_data['opening_hours']['open_now'],
      photo: @venue_data['photos'].first['photo_reference'])
    end
  end

  private

  def build_details_client(place_id)
    Adapter::PlaceDetailsWrapper.new(place_id)
  end
end
