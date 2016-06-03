class Venue < ActiveRecord::Base
  has_many :blacklists
  has_many :members, through: :blacklists

  validates :google_place_id, presence: true
end
