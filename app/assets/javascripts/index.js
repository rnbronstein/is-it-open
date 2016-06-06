
$(function(){
  $('.venue-info').hide()
  showInfo()
  hideInfo()

})

function showInfo(){
  $('.venue-img').mouseenter(function(e){
    // alert('made it this far')
    // debugger
    $(this).parent().parent().find('.venue-info').slideDown('slow')
    // debugger
  })
}

function hideInfo(){
  $('.venue-img').mouseleave(function(e){
    var info = $(this).parent().parent().find('.venue-info')
    info.slideUp('slow')

  })
}
