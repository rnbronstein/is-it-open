class Blacklist < ActiveRecord::Base
  belongs_to :venue
  belongs_to :member

  validates :member_id, presence: true
  validates :venue_id, presence: true
end
