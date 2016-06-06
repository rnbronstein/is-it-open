// $(function(){
//   submitForm()
// })
//
// function submitForm(){
//   $(".form-search-by-type").submit(function(e){
//     e.preventDefault
//     var searchType = $('input#search-type').val()
//     var searchKeyword = $('input#search-keyword').val()
//     if (searchKeyword) {
//       sendData(searchType, searchKeyword)
//     } else {
//       sendData(searchType)
//     }
//   })
// }
//
// function sendData(type, keyword = ""){
//   var data = {
//     'type': type,
//     'keyword': keyword
//   }
//   $.ajax({
//     url: '/search',
//     method: "POST",
//     dataType: "json",
//     data: JSON.stringify(data),
//     success: function(response){
//       alert("ajax success!")
//       console.log(response)
//     },
//     error: function(response){
//       alert("AJAX error :(")
//       console.log(response.responseText)
//     }
//   })
// }
//
// // function detailRequest(place_id){
// //   var data = {
// //     'place_id': place_id
// //   }
// //   $.ajax({
// //     url: <%= details_path %>,
// //     method: "POST",
// //     dataType: "json"
// //     data: JSON.stringify(data),
// //     success: alert("success"),
// //     error: alert("AJAX error")
// //   })
// // }
