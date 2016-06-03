class Blacklist < ActiveRecord::Base
  belongs_to :venue
  belongs_to :member
end
