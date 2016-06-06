class Venue < ActiveRecord::Base
  has_many :blacklists
  has_many :members, through: :blacklists

  validates :google_place_id, presence: true

  attr_accessor :formatted_address, :formatted_phone_number,
    :name, :opening_hours, :photos
end
