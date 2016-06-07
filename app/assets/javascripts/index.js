$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()
})

function showInfo(){
  $('.venue-thumbnail-frame').mouseenter(function(e){
    $(this).parent().parent().find('.helper img').fadeOut('400')
    $(this).parent().parent().find('.venue-info').slideDown('slow')
  })
}

function hideInfo(){
  $('.venue-thumbnail-frame').mouseleave(function(e){
    $(this).parent().parent().find('.helper img').fadeIn('400')
    var info = $(this).parent().parent().find('.venue-info')
    info.slideUp('slow')
  })
}

function onVenueHover(){
  $('.helper img').on('click', function(e){
    e.stopPropagation
    $(this).fadeOut('400')

    $('venue-info').fadeIn('400')
  })
}
