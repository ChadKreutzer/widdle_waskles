$(document).ready(function(){
  
  $('.navbar-collapse a').click(function(){
    $(".navbar-collapse").collapse('hide');
  });
  
  $("#testimony").addClass("splash").fadeIn(500);
    setTimeout(function() {
      $("#testimony").fadeOut(2000, function() {
        $(this).removeClass("splash");
      });
   }, 5000);
   
  (function() {
      var elem = document.createElement('input');
      elem.setAttribute('type', 'date');
 
      if ( elem.type === 'text' ) {
        $('.date').datepicker({
          dateFormat: 'yy-mm-dd'
        }); 
      }
   })();
});