class BlacklistsController < ApplicationController

  def create
    #blacklist creator service
    @google_place_id = params[:place_id]
    Blacklister.new(@google_place_id)
    render :json => { place_id: @google_place_id}
  end
end
