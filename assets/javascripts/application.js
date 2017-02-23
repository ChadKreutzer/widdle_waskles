$(document).ready(function(){
  $("#testimony").addClass("splash").fadeIn(500);
    setTimeout(function() {
      $("#testimony").fadeOut(2000, function() {
        $(this).removeClass("splash");
      });
   }, 15000);
});