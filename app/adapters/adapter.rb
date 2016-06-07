require 'rest-client'
require 'json'

module Adapter
  class GooglePlacesWrapper
    def initialize(type: type, latitude: latitude, longitude: longitude)
      @key = ENV['google_api_key']
      @type = type
      @latitude = latitude
      @longitude = longitude
    end

    def base_url
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    end

    def search_params
      "&location=#{@latitude},#{@longitude}&rankby=distance&types=#{@type}&key=#{@key}"
    end

    def url
      base_url + search_params
    end

    def call
      response = RestClient.get(url)
      JSON.parse(response)
    end
  end

  class PlaceDetailsWrapper
    def initialize(place_id)
      @place_id = place_id
      @key = ENV['google_api_key']
    end

    def details_call
      url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{@place_id}&key=#{@key}"
      response = RestClient.get(url)
      JSON.parse(response)
    end
  end
end
