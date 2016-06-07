$(function(){
  callForExtendedVenueData()
})

function callForExtendedVenueData(){
  $.ajax({
    url: '/get_extended_details',
    method: "POST",
    success: function(response){
      // alert("ajax success!")
    },
    error: function(response){
      alert("AJAX error :(")
    }
  })
}
