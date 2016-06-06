class HomeController < ApplicationController
  before_action :initialize_google_client, only: [:index, :search]

  def index

  end

  def search
    render :json => { response_string: @google_client.search_call()}
  end

  def default
    render :json => { response_string: @google_client.default_call()}
  end

  private

  def set_location
    @coordinates = Geocoder.coordinates(set_ip)
    @latitude = @coordinates.first
    @longitude = @coordinates.last
  end

  def initialize_google_client
    set_location
    @google_client = Adapter::GooglePlacesWrapper.new(type: "restaurant",
      latitude: @latitude, longitude: @longitude)
  end
end
