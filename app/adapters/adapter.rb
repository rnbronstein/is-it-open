module Adapter
  class GooglePlacesWrapper

    def initialize
      @key = ENV['google_api_key']
      @url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+Sydney&key=' + @key
    end

  end
end
