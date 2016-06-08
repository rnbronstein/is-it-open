$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()
})

function showInfo(){
  $('.venue-thumbnail-frame').mouseenter(function(e){
    $(this).parent().parent().find('.helper img').hide(function(){
      $(this).parent().parent().find('.venue-info').show()
    })
  })
}


function hideInfo(){
  $('.venue-thumbnail-frame').mouseleave(function(e){
    var info = $(this).parent().parent().find('.venue-info')
    info.hide(function(){
      $(this).parent().parent().find('.helper img').show()
    })
  })
}
