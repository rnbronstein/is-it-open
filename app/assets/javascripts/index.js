$(function(){
})

function submitForm(){
  $(".form-search-by-type").submit(function(e){
    e.preventDefault
    var searchType = $('input#search-type').val()
    var searchKeyword = $('input#search-keyword').val()
  })
}

function ApiKey(key){
  this.key = key;
}

function retrieveKey(){
  
}
