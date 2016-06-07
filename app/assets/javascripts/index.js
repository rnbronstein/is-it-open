$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()
})

function showInfo(){
  $('.venue-thumbnail-frame').mouseenter(function(e){
    $(this).parent().parent().find('.venue-info').slideDown('slow')
  })
}

function hideInfo(){
  $('.venue-thumbnail-frame').mouseleave(function(e){
    var info = $(this).parent().parent().find('.venue-info')
    info.slideUp('slow')
  })
}
