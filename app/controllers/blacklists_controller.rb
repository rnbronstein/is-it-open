class BlacklistsController < ApplicationController

  def create
    #blacklist creator service
    respond_to do |format|
      format.js
    end
  end
end
