class HomeController < ApplicationController
  before_action :search_client, only: [:index, :search]

  def index
    @venues = []
  end

    # Loop through the default_call and add Venue.new objects to
    # the @venues array. Each Venue.new object will require its
    # own call to the details API.


  def default
    render :json => { response_string: @google_client.default_call()}
#    @google_client.default_call().each do |venue|
#      @venues << Venue.new(@google_client.details_call(venue))
#    end

    #vs.
    @search_client.default_call()['results'].each do |venue|
      @details_client = place_details_client(venue)
      @venues << @details_client.details_call #returns a JSON element { name: "Spock's restaurant", }
    end

    #binding.pry
    # Move this logic to a service. Use attr accessors in the Venue model to build temporary Venue objects.
    # @venues = VenueFetcher.new.fetch_venues
  end


  private

  def set_location
    @coordinates = Geocoder.coordinates(set_ip)
    @latitude = @coordinates.first
    @longitude = @coordinates.last
  end

  def search_client
    set_location
    @search_client = Adapter::GooglePlacesWrapper.new(type: "restaurant",
      latitude: @latitude, longitude: @longitude)
  end

end
