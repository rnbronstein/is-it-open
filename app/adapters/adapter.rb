require 'rest-client'
require 'json'

module Adapter
  class GooglePlacesWrapper

    def initialize(type: type, latitude: latitude, longitude: longitude, keyword: nil)
      @key = ENV['google_api_key']
      @type = type
      @latitude = latitude
      @longitude = longitude
      @keyword = keyword
    end

    def base_url
      'https://maps.googleapis.com/maps/api/place/radarsearch/json?'
    end

    def call
      url_params = "location=#{@latitude},#{@longitude}&openNow=true&radius=5000&type=#{@type}&keyword=#{@keyword}&key=#{@key}"
      response = RestClient.get(base_url + url_params)
      binding.pry
      JSON.parse(response)
    end

    class PlaceDetailsWrapper
      def initialize(place_id)
        @place_id = place_id
        @key = ENV['google_api_key']
      end

      def call
        url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{@place_id}&key=#{@key}"
        response = RestClient.get(url)
        JSON.parse(response)
      end

    end

# https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&type=museum&opennow&key=AIzaSyCY1evTMnMd-GWCnR0_1yWAK40pZBo9vo4
#
# https://maps.googleapis.com/maps/api/place/radarsearch/json?location=40.9513,-73.8773&radius=5000&type=cafe&key=AIzaSyCY1evTMnMd-GWCnR0_1yWAK40pZBo9vo4

    # def run_search
    #
    #
    #   #Venue.new(google_place_id: data['results'].first['place_id'])
    #
    #   debugger
    #
    #   data
    #   #return an array of venues
    # end
    #
    # def get_details
    # end

  end
end
