$(document).ready(function(){
  $(".sidebar-link").click(function(e) {
    $($(this).data('target')).addClass('hidden');
  });
});
