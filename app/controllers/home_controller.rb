class HomeController < ApplicationController
  before_action :set_location, only: [:index, :search]

  def index
    # Adapters
    # - Connect to Google Places.
    # g_places_api = Adapter::GooglePlacesWrapper.new
    #
    # g_places_api.run_search
    # Create a venue object
    # -services for the Venue Model for extracting the fields we want.
  end

  def search
    # binding.pry
    # @type = params[:type]
    # @keyword = params[:keyword] if params[:keyword]

    google_api = Adapter::GooglePlacesWrapper.new(type: params[:type], latitude: @latitude, longitude: @longitude, keyword: params[:keyword])
    google_api.call
    render :json => { response_string: google_api.call}
  end

  private

  def set_location
    @coordinates = Geocoder.coordinates(set_ip)
    @latitude = @coordinates.first
    @longitude = @coordinates.last
  end

end
