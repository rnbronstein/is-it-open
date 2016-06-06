class IpLocator
  attr_accessor :latitude, :longitude

  def initialize(ip)
    coordinates = Geocoder.coordinates(ip)
    @latitude = coordinates.first
    @longitude = coordinates.last
  end
end
