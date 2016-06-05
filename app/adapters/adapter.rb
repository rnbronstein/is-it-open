require 'rest-client'
require 'json'

module Adapter
  class GooglePlacesWrapper

    def initialize
      @key = ENV['google_api_key']
    end

    def base_url
      'https://maps.googleapis.com/maps/api/place/'
    end

    def run_search
      url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+Sydney&key=' + @key

      response = RestClient.get(url)
      data = JSON.parse(response)
      #Venue.new(google_place_id: data['results'].first['place_id'])

      debugger

      data
      #return an array of venues
    end

    def get_details
    end

  end
end
