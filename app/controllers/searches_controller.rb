class SearchesController < ApplicationController
  before_action :initialize_google_client

  def create
    @venues = VenueLister.new(set_location, set_type).venues_with_reduced_details
    respond_to do |format|
      format.js
    end
  end


  private

  def set_type
    type = params[:type]
    downcased = type.downcase
    result = downcased.gsub(" ", "_")
    result
    # binding.pry
  end

  def set_location
  #   binding.pry
    if params[:location].blank?
      @coordinates = Geocoder.coordinates(set_ip)
    else
      @coordinates = Geocoder.coordinates(params[:location])
    end
    # binding.pry
  end

  def initialize_google_client
    set_location
    @google_client = Adapter::GooglePlacesWrapper.new(type: params[:type],
      latitude: @latitude, longitude: @longitude)
  end

end
