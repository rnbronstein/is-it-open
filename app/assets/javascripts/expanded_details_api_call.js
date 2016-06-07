$(function(){
  populateDisplayedVenuesDetails()
})

function populateDisplayedVenuesDetails(){
  var displayedVenues = getDisplayedVenueIdentifiers()

  for(var i = 0; i < displayedVenues.length; i++) {
    displayVenueDetails(displayedVenues[i])
  }
}

function displayVenueDetails(venue){
  var venueIdentifier = {
    'place_id' : venue.attributes[1].value
  }

  callForVenueDetails(venueIdentifier)
}

function getDisplayedVenueIdentifiers(){
  return $('.venue-thumbnail-frame')
}

function callForVenueDetails(venueIdentifier){
  $.ajax({
    url: '/call_for_venue_details',
    method: "POST",
    dataType: "json",
    data: venueIdentifier,
    success: function(response){
      appendVenueDetailsToView(response, venueIdentifier)
    },
    error: function(response){
      console.log("API call error.")
    }
  })
}

function appendVenueDetailsToView(response, venueIdentifier){
  var phone_number = response['formatted_phone_number']
  $('div[place-id='+venueIdentifier['place_id']+'] h5.venue-title').append(phone_number)
}
