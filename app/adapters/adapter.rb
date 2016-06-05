module Adapter
  class GooglePlacesWrapper
    attr_accessor :key, :url

    def initialize(location_x: "-33.8670522", location_y: "151.1957362", radius: '100', type: 'restaurant')
      @location_x = location_x
      @location_y = location_y
      @radius = radius

      @key = ENV['google_api_key']

      @places_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location_x},#{location_y}&radius=#{radius}&type=#{type}&key=#{@key}"
    end

    def get_search_url(type, keyword)
      search_keyword = keyword.gsub(" ", "+")
      "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=#{@location_x},#{@location_y}&radius=#{@radius}&type=#{type}&keyword=#{search_keyword}&key=#{@key}"
    end

    def get_details_url(place_id)
      "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{@key}"
    end
  end
end
