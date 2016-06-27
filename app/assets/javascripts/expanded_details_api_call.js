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
  //var now = new Date()
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
      console.log(response)
      appendAllDetails(response, venueIdentifier)
    },
    error: function(response){
      console.log("API call error.")
    }
  })
}

// ------------- TIME CALCULATIONS -------------
var time = moment().local(); //local time right now
var today = time.weekday();
var rightNow = currentTimeInMinutes(time);

function currentTimeInMinutes(time){
  return moment.duration({
    hours: time.hours(),
    minutes: time.minutes()
  }).asMinutes();
}

function setTimeInMinutes(time){
  var timeAsMoment = moment(`${time}`, 'hhmm');
  return moment.duration({
    hours: timeAsMoment.hours(),
    minutes: timeAsMoment.minutes()
  }).asMinutes();
}

function openTime(venueTimeObject, currentDay){
  return parseInt(venueTimeObject['periods'][currentDay]['open']['time']);
}

function closeTime(venueTimeObject, currentDay){
  return parseInt(venueTimeObject['periods'][currentDay]['close']['time']);
}

function is24HourVenue(venueTimeObject, currentDay){
  debugger;
  if (venueTimeObject['periods'][currentDay]['close']['time'] === '00:00'){
    return true;
  }
}

function calculateTimeToChangeStatus(venueTimeObject){
  if (is24HourVenue(venueTimeObject, today)) {
    return null;
  } else {
    var openTimeValue = openTime(venueTimeObject, today);
    var open = setTimeInMinutes(openTimeValue);
    var closeTimeValue = closeTime(venueTimeObject, today);
    var close = setTimeInMinutes(closeTimeValue);
    if (venueTimeObject['open_now'] === true){
      return close - rightNow;
    } else if (venueTimeObject['open_now'] === false) {
      return calculateNextTimeOpen(venueTimeObject, rightNow);
    }
  }
}

function calculateNextTimeOpen(venueTimeObject, currentTime){
  var openTimeToday = openTime(venueTimeObject, today);
  var openTimeTomorrow = openTime(venueTimeObject, (today + 1));
  if (currentTime > setTimeInMinutes(openTimeToday)){
    var timeUntilTomorrow = 1400 - rightNow;
    var timeOpenTomorrow = setTimeInMinutes(openTimeTomorrow);
    return timeUntilTomorrow + timeOpenTomorrow;
  } else {
    var openingTimeInMinutes = setTimeInMinutes(openTimeToday);
    debugger;
    return openingTimeInMinutes - currentTime;
  }
}

function appendTimeStatusDetails(response, venueIdentifier){
  var venueTimeObject = response['opening_hours']
  var timeToChange = calculateTimeToChangeStatus(venueTimeObject);
  // var timeToChange = setTimeInMinutes(timeCalculation);
  if (response['opening_hours']['open_now'] === false){
    renderVenue(venueIdentifier, 'closed', timeToChange)
  } else {
    renderVenue(venueIdentifier, 'open', timeToChange)
  }
}

function renderVenue(venueIdentifier, status, timeToChange){
  if (timeToChange > 60){
    var hoursToChange = Math.floor(timeToChange / 60);
    var minutesToChange = timeToChange % 60;
  } else {
    var hoursToChange = 0;
    var minutesToChange = timeToChange;
  }
  if (status === 'open') {
    appendTimePanel(venueIdentifier, hoursToChange, minutesToChange, 'time-to-open');
    appendTimeStatusText(venueIdentifier, hoursToChange, minutesToChange, "Closing");
  } else if (status === 'closed') {
    appendTimePanel(venueIdentifier, hoursToChange, minutesToChange, 'time-to-close');
    appendTimeStatusText(venueIdentifier, hoursToChange, minutesToChange, "Opening");
  }
}

function appendTimePanel(venueIdentifier, hoursToChange, minutesToChange, css){
  $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
    if (hoursToChange === 0){
      $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>:" + minutesToChange + "</h3>");
    } else {
      if(minutesToChange > 9){
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToChange + ":" + minutesToChange + "</h3>");
      } else{
        $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToChange + ":0" + minutesToChange + "</h3>");
      }
    $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass(css);
    }
  });
}

function appendTimeStatusText(venueIdentifier, hoursToChange, minutesToChange, statusText){
  if (hoursToChange === 0) {
    $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>" + statusText + " in:</strong> " + minutesToChange + " minutes</p>");
  } else {
    $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>" + statusText + " in:</strong> " + hoursToChange + " hours and " + minutesToChange + " minutes</p>");
  }
}

function appendTimeText(response, venueIdentifier){
  var hours = response['opening_hours']['weekday_text'][today];
  var formattedHours = hours.split(': ')[1];
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Today's Hours:</strong> <br>" + formattedHours + "</p>");
}

function appendPhoneNumber(response, venueIdentifier){
  var phoneNumber = response['formatted_phone_number']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Phone:</strong> " + phoneNumber + "</p>")
}

function appendAddress(response, venueIdentifier){
  var address = response['address_components'][0]['long_name'] + " " + response['address_components'][1]['long_name']
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Address:</strong> " + address + "</p>")
}

function appendRating(response, venueIdentifier){
  if (response['rating']) {
    var rating = response['rating']
  } else {
    var rating = "Not rated"
  }
  $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Rating:</strong> " + rating + "</p>")
}

function appendAllDetails(response, venueIdentifier){
  var id = venueIdentifier;
  appendTimeStatusDetails(response, id);
  appendTimeText(response, id);
  appendPhoneNumber(response, id);
  appendAddress(response, id);
  appendRating(response, id);
}

// function getTime(venue_times, current_day, status){
//   return venue_times['periods'][current_day - 1][status]
// }
//
// function getHoursAndMinutes(time){
//
//   var hourMinuteTime = {
//     'minutes': parseInt(time.substring(2,4)),
//     'hours': parseInt(time.substring(0,2))
//   }
//
//   return hourMinuteTime
// }
//
// function toMinutes(minutes, hours){
//   return minutes + (hours * 60)
// }
//
// function calculateMinutesToClose(venue_times){
//   var now = new Date()
//   var day =  now.getDay()
//   var hours = now.getHours()
//   var minutes = now.getMinutes()
//   var userMinuteTime = minutes + (hours * 60)
//
//   if(venue_times['periods'][day-1]['open']['time'] === "00:00"){
//     return null
//   }else{
//
//     var closingTime = getTime(venue_times, day, 'close')
//     var openingTime = getTime(venue_times, day, 'open')
//
//     var closingHoursMinutes = getHoursAndMinutes(closingTime['time'])
//     var openingHoursMinutes = getHoursAndMinutes(openingTime['time'])
//
//     var closingMinutes = toMinutes(closingHoursMinutes['minutes'], closingHoursMinutes['hours'])
//     var openingMinutes = toMinutes(openingHoursMinutes['minutes'], openingHoursMinutes['hours'])
//
//     if(closingMinutes < openingMinutes){
//       closingMinutes += 1440
//     }
//
//     var minutesToClose = closingMinutes - userMinuteTime
//
//     if(venue_times['open_now'] === false){
//       return openingMinutes - userMinuteTime
//     }else{
//       return minutesToClose
//     }
//   }
// }
//
//
// function appendVenueDetailsToView(response, venueIdentifier){
//   var now = new Date()
//   var day =  now.getDay()
//   var hours = response['opening_hours']['weekday_text'][day - 1]
//   var formattedHours = hours.split(': ')[1]
//   $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Today's Hours:</strong> <br>" + formattedHours + "</p>")
//
//   var minutesToClose = calculateMinutesToClose(response['opening_hours'])
//
//   if(response['opening_hours']['open_now'] === false){
//     //render a closed venue
//     var timeToOpenOrClose = minutesToClose
//
//     if(timeToOpenOrClose > 60){
//       var hoursToOpen = Math.floor(timeToOpenOrClose / 60)
//       var minutesToOpen = timeToOpenOrClose % 60
//       $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Opening in:</strong> " + hoursToOpen + " hours and " + minutesToOpen + " minutes</p>")
//
//       $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
//         if(minutesToOpen > 9){
//           $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":" + minutesToOpen + "</h3>")
//         }else{
//           $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":0" + minutesToOpen + "</h3>")
//         }
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-close")
//       })
//     }else{
//       $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Opening in:</strong> " + timeToOpenOrClose + " minutes</p>")
//
//       $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>:" + timeToOpenOrClose + "</h3>")
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-close")
//       })
//     }
//   }else{
//     //render an open venue
//     var timeToOpenOrClose = minutesToClose
//
//     if(timeToOpenOrClose > 60){
//       var hoursToOpen = Math.floor(timeToOpenOrClose / 60)
//       var minutesToOpen = timeToOpenOrClose % 60
//
//       $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Closing in:</strong> " + hoursToOpen + " hours and " + minutesToOpen + " minutes</p>")
//
//       $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
//         if(minutesToOpen > 9){
//           $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":" + minutesToOpen + "</h3>")
//         }else{
//           $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>" + hoursToOpen + ":0" + minutesToOpen + "</h3>")
//         }
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-open")
//       })
//     }else{
//       $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Closing in:</strong> " + timeToOpenOrClose + " minutes</p>")
//
//       $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').fadeIn('400', function(){
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').append("<h3>:" + timeToOpenOrClose + "</h3>")
//         $('div[place-id='+venueIdentifier['place_id']+'] .time-panel').addClass("time-to-open")
//       })
//     }
//   }
//
//   var formatted_phone_number = response['formatted_phone_number']
//   $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Phone:</strong> " + formatted_phone_number + "</p>")
//
//   var formatted_address = response['address_components'][0]['long_name'] + " " + response['address_components'][1]['long_name']
//   $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Address:</strong> " + formatted_address + "</p>")
//
//   if (response['rating']) {
//     var rating = response['rating']
//   } else {
//     var rating = "Not rated"
//   }
//   $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<p><strong>Rating:</strong> " + rating + "</p>")
//
//   // var website = response['website']
//   // if(website){
//   //   $('div[place-id='+venueIdentifier['place_id']+'] .venue-info').append("<a href='" + website + "' target='_blank'>website</a></p>")
//   // }
// }
