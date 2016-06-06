class SearchesController < ApplicationController
  before_action :initialize_google_client

  def create
    #
    @venues = all the stuff

    respond_to do |format|
      format.js
    end
    #render :json => { response_string: @google_client.search_call()}
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
