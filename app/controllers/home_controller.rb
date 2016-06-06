class HomeController < ApplicationController
  before_action :set_location, only: [:index, :search]

  def index
    @key = ENV['google_api_key']

    # Adapters
    # - Connect to Google Places.
    # g_places_api = Adapter::GooglePlacesWrapper.new
    #
    # g_places_api.run_search
    # Create a venue object
    # -services for the Venue Model for extracting the fields we want.
  end

  private

  def set_location
    @coordinates = Geocoder.coordinates(set_ip)
    @latitude = @coordinates.first
    @longitude = @coordinates.last
  end

end
