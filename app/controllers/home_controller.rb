class HomeController < ApplicationController
  before_action :initialize_google_client, only: [:index, :search]

  def index
    @venues = []

    # Loop through the default_call and add Venue.new objects to
    # the @venues array. Each Venue.new object will require its
    # own call to the details API.

#    @google_client.default_call().each do |venue|
#      @venues << Venue.new(@google_client.details_call(venue))
#    end

    #vs.
    @google_client.default_call()['results'].each do |venue|
      @venues << @google_client.details_call(venue) #returns a JSON element { name: "Spock's restaurant", }
    end
  end

  def search
    render :json => { response_string: @google_client.search_call()}
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
