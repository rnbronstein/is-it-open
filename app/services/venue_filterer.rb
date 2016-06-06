class VenueFilterer
  attr_accessor :filtered_venues
    def initialize(ip, type)
      @ip = ip
      @type = type
      @filtered_venues = []
      run_filters
    end

    def run_filters
      @filtered_venues += VenueLister.new(@ip, @type).venues_with_details
      run_filters if @filtered_venues.length < 10
    end
end
