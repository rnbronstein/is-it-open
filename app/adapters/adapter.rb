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
      'https://maps.googleapis.com/maps/api/place/radarsearch/json?radius=500'
    end

    def default_params
      "&location=#{@latitude},#{@longitude}&type=#{@type}&key=#{@key}"
    end

    def search_params
      "&location=#{@latitude},#{@longitude}&type=#{@type}&keyword=#{@keyword}&key=#{@key}"
    end

    def url
      base_url + search_params
    end

    def search_call
      response = RestClient.get(url)
      JSON.parse(response)
    end

    def default_call
      response = RestClient.get(base_url + default_params)
      JSON.parse(response)
    end
  end

  def call
    url_params = "location=#{@latitude},#{@longitude}&openNow=true&radius=5000&type=#{@type}&keyword=#{@keyword}&key=#{@key}"
    response = RestClient.get(base_url + url_params)
    #binding.pry
    JSON.parse(response)
  end

  class PlaceDetailsWrapper
    def initialize(place_id)
      @place_id = place_id
      @key = ENV['google_api_key']
    end

    def details_call
      url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{@place_id}&key=#{@key}"
      response = RestClient.get(url)
      JSON.parse(response)
    end

  end
end
