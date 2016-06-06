class HomeController < ApplicationController
  def index
    @venues = VenueLister.new(set_ip).venues_with_details
  end

  def search
    render :json => { response_string: @search_client.search_call()}
  end
end
