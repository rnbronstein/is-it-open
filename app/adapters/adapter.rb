require 'rest-client'
require 'json'

module Adapter
  class GooglePlacesWrapper
    def initialize(type: type, latitude: latitude, longitude: longitude, keyword: nil)
      @key = ENV['google_api_key']
      @type = type
      @latitude = latitude
      @longitude = longitude
    end

    def base_url
      'https://maps.googleapis.com/maps/api/place/radarsearch/json?radius=500'
    end

    def default_params
      "&location=#{@latitude},#{@longitude}&type=#{@type}&key=#{@key}"
    end

    def search_params(keyword, type = @type)
      "&location=#{@latitude},#{@longitude}&type=#{type}&keyword=#{keyword}&key=#{@key}"
    end

    def search_call
      response = RestClient.get(base_url + search_params)
      JSON.parse(response)
    end

    def default_call
      response = RestClient.get(base_url + default_params)
      JSON.parse(response)
    end
  end
end
