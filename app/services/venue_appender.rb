class VenueAppender

  def make_call(params)
    @result = VenueLister.new(params)
  end

  def more_pages?
    true if @result["next_page_token"]
  end

  def page_token
    @result["next_page_token"] if more_pages?
  end

  def new_call(params)
    VenueLister.new(params[:location], params[:type]).venues_with_reduced_details    
  end
end
