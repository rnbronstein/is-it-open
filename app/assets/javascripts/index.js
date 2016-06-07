$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()
})

function showInfo(){
  $('.venue-thumbnail-frame').mouseenter(function(e){
    $(this).parent().parent().find('.helper img').fadeOut('400')
    $(this).parent().parent().find('.venue-info').fadeIn('400')
  })
}

function hideInfo(){
  $('.venue-thumbnail-frame').mouseleave(function(e){
    $(this).parent().parent().find('.helper img').fadeIn('400')
    var info = $(this).parent().parent().find('.venue-info')
    info.fadeOut('400')
  })
}
