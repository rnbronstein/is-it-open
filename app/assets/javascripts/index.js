
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
  $('.venue-info').mouseleave(function(e){
    $(this).slideUp('slow')
    $(this).hide()
  })
}
