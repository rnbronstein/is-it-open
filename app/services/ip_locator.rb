class IpLocator
  attr_accessor :latitude, :longitude

  def initialize(ip) #this might be a set of coordinates already - that's okay
    coordinates = Geocoder.coordinates(ip)
    @latitude = coordinates.first
    @longitude = coordinates.last
  end
end
