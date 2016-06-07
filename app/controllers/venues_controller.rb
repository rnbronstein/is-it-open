class VenuesController < ApplicationController
  def call_for_venue_details
    @venue_details = VenueCreator.new.get_venue_expanded_details(params['place_id'])
    respond_to do |format|
      format.json { render json: @venue_details }
    end
  end
end
