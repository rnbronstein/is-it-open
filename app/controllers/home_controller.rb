class HomeController < ApplicationController
  def index
    @venues = VenueLister.new(set_ip, "restaurant").venues_with_reduced_details
  end
end
