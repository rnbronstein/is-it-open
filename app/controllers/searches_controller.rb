class SearchesController < ApplicationController
  before_action :initialize_google_client

  def create
    @venues = VenueLister.new(set_ip, params[:type], params[:keyword]).venues_with_details
    respond_to do |format|
      format.js
      # format.json {
      #   render json: @venues
      # }
    end
  end


  private

  def set_location
    @coordinates = Geocoder.coordinates(set_ip)
    @latitude = @coordinates.first
    @longitude = @coordinates.last
  end

  def initialize_google_client
    set_location
    @google_client = Adapter::GooglePlacesWrapper.new(type: params[:type],
      latitude: @latitude, longitude: @longitude, keyword: params[:keyword])
  end

end
