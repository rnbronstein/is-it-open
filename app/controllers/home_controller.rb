class HomeController < ApplicationController
  def index
     @venues = VenueLister.new(set_ip).venues_with_details
  end

end
