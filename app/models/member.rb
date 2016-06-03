class Member < ActiveRecord::Base
  has_many :blacklists
  has_many :venues, through: :blacklists

  validates :name, presence: true
  validates :uid, presence: true
end
