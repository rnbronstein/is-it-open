class VenueDecorator < SimpleDelegator
  def photo_reference_url
    reference = self.photos
    key = ENV['google_api_key']
    "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=#{reference}&key=#{key}"
  end
end
