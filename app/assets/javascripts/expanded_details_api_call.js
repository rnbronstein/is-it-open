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
  var now = new Date()
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

// ------------- TIME CALCULATIONS -------------
function getTime(venue_times, current_day, status){
  return venue_times['periods'][current_day - 1][status]
}

function getHoursAndMinutes(time){

  var hourMinuteTime = {
    'minutes': parseInt(time.substring(2,4)),
    'hours': parseInt(time.substring(0,2))
  }

  return hourMinuteTime
}

function toMinutes(minutes, hours){
  return minutes + (hours * 60)
}

function calculateMinutesToClose(venue_times){
  var now = new Date()
  var day =  now.getDay()
  var hours = now.getHours()
  var minutes = now.getMinutes()
  var userMinuteTime = minutes + (hours * 60)

  if(venue_times['periods'][day-1]['open']['time'] === "00:00"){
    return null
  }else{

    var closingTime = getTime(venue_times, day, 'close')
    var openingTime = getTime(venue_times, day, 'open')

    var closingHoursMinutes = getHoursAndMinutes(closingTime['time'])
    var openingHoursMinutes = getHoursAndMinutes(openingTime['time'])

    var closingMinutes = toMinutes(closingHoursMinutes['minutes'], closingHoursMinutes['hours'])
    var openingMinutes = toMinutes(openingHoursMinutes['minutes'], openingHoursMinutes['hours'])

    if(closingMinutes < openingMinutes){
      closingMinutes += 1440
    }

    var minutesToClose = closingMinutes - openingMinutes
    if(venue_times['open_now'] === false){
      debugger
    }else{
      return minutesToClose
    }
  }
}

function appendVenueDetailsToView(response, venueIdentifier){
  var now = new Date()
  var day =  now.getDay()

  var hours = response['opening_hours']['weekday_text'][day - 1]
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Hours: " + hours + "</p>")

  var minutesToClose = calculateMinutesToClose(response['opening_hours'])


  if(response['opening_hours']['open_now'] === false){
    //render a closed venue
    var timeToOpenOrClose = minutesToClose

    if(timeToOpenOrClose > 60){
      var hoursToOpen = Math.floor(timeToOpenOrClose / 60)
      var minutesToOpen = timeToOpenOrClose % 60
      $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Opening in: " + hoursToOpen + " hours and " + minutesToOpen + " minutes.</p>")

      $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":" + minutesToOpen + "</h3>")
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-close")
      })
    }else{
      $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Opening in: " + timeToOpenOrClose + " minutes.</p>")

      $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + timeToOpenOrClose + "</h3>")
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-close")
      })
    }
  }else{
    //render an open venue
    var timeToOpenOrClose = minutesToClose

    if(timeToOpenOrClose > 60){
      var hoursToOpen = Math.floor(timeToOpenOrClose / 60)
      var minutesToOpen = timeToOpenOrClose % 60

      $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Closing in: " + hoursToOpen + " hours and " + minutesToOpen + " minutes.</p>")

      $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":" + minutesToOpen + "</h3>")
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-open")
      })
    }else{
      $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Closing in: " + timeToOpenOrClose + " minutes.</p>")

      $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + timeToOpenOrClose + "</h3>")
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-open")
      })
    }
  }

  var formatted_phone_number = response['formatted_phone_number']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Phone: " + formatted_phone_number + "</p>")

  var formatted_address = response['address_components'][0]['long_name'] + " " + response['address_components'][1]['long_name']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Address: " + formatted_address + "</p>")

  var rating = response['rating']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Rating: " + rating + "</p>")

  var website = response['website']
  if(website){
    $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p>Website: <a href='" + website + "' target='_blank'>website</a></p>")
  }
}
