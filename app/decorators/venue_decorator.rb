class VenueDecorator < SimpleDelegator
  def set_image
    if default?
      default_image_tag
    else
      "<img class='venue-img' src='#{set_url}' alt='#{self.name}' />".html_safe
    end
  end

private
  def set_url
    reference = self.photo
    key = ENV['google_api_key']
    "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=#{reference}&key=#{key}"
  end

  def default_image_tag
    ActionController::Base.helpers.image_tag('defaultimage.png', alt: "#{self.name}", class: 'venue-img')
  end

  def default?
    self.photo == "defaultimage"
  end
end
