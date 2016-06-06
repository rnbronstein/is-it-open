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
      'https://maps.googleapis.com/maps/api/place/radarsearch/json?radius=500&opennow'
    end

    def call
      url_params = "&location=#{@latitude},#{@longitude}&type=#{@type}&keyword=#{@keyword}&key=#{@key}"
      binding.pry
      response = RestClient.get(base_url + url_params)
      JSON.parse(response)
    end



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
