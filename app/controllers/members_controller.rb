class MembersController < ApplicationController

  def preferences
    blacklist = Blacklist.where(member: current_user)
    @venues = blacklist.pluck(:venue)
  end

end
