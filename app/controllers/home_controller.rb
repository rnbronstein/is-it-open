class HomeController < ApplicationController
  def index
    @venues = VenueLister.new(set_ip, "restaurant").venues_with_details
  end
end
