$(function(){
  buttonClick()
})

function buttonClick(){
  $('button.close').click(function(e){
  e.stopPropagation
  $(this).parent().fadeOut('400')
})
}
