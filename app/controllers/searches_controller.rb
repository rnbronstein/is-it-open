class SearchesController < ApplicationController
  before_action :initialize_google_client

  def create
    @venues = VenueLister.new(set_location, params[:type], params[:keyword]).venues_with_details
    respond_to do |format|
      format.js
      # format.json {
      #   render json: @venues
      # }
    end
  end


  private

  def set_location
    if params[:location]
      @coordinates = Geocoder.coordinates(params[:location])
    else
      @coordinates = Geocoder.coordinates(set_ip)
    end
  end

  def initialize_google_client
    set_location
    @google_client = Adapter::GooglePlacesWrapper.new(type: params[:type],
      latitude: @latitude, longitude: @longitude, keyword: params[:keyword])
  end

end
