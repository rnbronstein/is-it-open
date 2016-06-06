// on click, send place id to blacklist controller, which will save the venue
$(function(){
  buttonClick()
})

function buttonClick(){
  $('button.close').click(function(e){
  e.stopPropagation
  $(this).parent().fadeOut('400', function(){
    var placeID = $(this).parent().find('p.place-id')
  })
})
}

// function sendBlacklistVenue(placeID){
//   var data = {
//     'place_id': placeID
//   }
//   $.ajax({
//     url: '/create_venue',
//     method: 'POST',
//     dataType: 'json',
//     data: JSON.stringify(data),
//     success: function(response){
//       console.log(response)
//     }
//   })
// }
