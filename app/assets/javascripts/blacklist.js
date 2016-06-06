// on click, send place id to blacklist controller, which will save the venue
$(function(){
  buttonClick()
})

function buttonClick(){
  $('button.close').click(function(e){
  e.stopPropagation
  $(this).parent().fadeOut('400', function(){
    var placeID = $('p.place-id')
    sendBlacklistVenue(placeID)
  })
})
}

function sendBlacklistVenue(placeID){
  var data = {
    'place_id': placeID
  }
  $.ajax({
    url: '/create',
    method: 'POST',
    dataType: 'json',
    data: JSON.stringify(data),
    success: function(response){
      alert(response)
    }
    error: alert("error :(")
  })
}
