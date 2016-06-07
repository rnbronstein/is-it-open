class VenuesController < ApplicationController

  def get_extended_details
    #get extended details with place_ids (for the selector)
    binding.pry
    respond_to do |format|
      format.js
    end
  end
end
