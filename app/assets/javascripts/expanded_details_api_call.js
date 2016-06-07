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
  var formatted_phone_number = response['formatted_phone_number']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Phone: " + formatted_phone_number + "</p>")

  var formatted_address = response['address_components'][0]['long_name'] + ", " + response['address_components'][1]['long_name']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Address: " + formatted_address + "</p>")

  var rating = response['rating']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Rating: " + rating + "</p>")

  var website = response['website']
  if(website){
    $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Website: <a href='" + website + "' target='_blank'>website</a></p>")
  }
}
