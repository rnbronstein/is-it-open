class Blacklister

  def save_venue
    @venue = Venue.create(@google_place_id)
  end
end
