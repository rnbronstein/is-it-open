
$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()
})

function showInfo(){
  $('.venue-img').mouseenter(function(e){
    $(this).parent().parent().find('.venue-info').slideDown('slow')
  })
}

function hideInfo(){
  $('.venue-img').mouseleave(function(e){
    var info = $(this).parent().parent().find('.venue-info')
    info.slideUp('slow')
  })
}

function getDefaultVenues(type){
  // debugger
}
