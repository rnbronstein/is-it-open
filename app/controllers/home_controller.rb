class HomeController < ApplicationController
  def index
#    @venues = VenueLister.new(set_ip, "restaurant").venues_with_details
    @venues = VenueFilterer.new(set_ip, "restaurant").filtered_venues
  end
end
