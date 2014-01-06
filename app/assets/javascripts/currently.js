$(function() {
  initPage();
});
$(window).bind('page:change', function() {
  initPage();
});
function initPage() {
  $(document).ready(function() {

    $('#update-status').focus();
    $('.fade').fadeOut(4000);

    if (window.location.hash == '#_=_'){
        history.replaceState 
            ? history.replaceState(null, null, window.location.href.split('#')[0])
            : window.location.hash = '';
    }
    
    updateCountdown();
    $('#update-status').change(updateCountdown);
    $('#update-status').keyup(updateCountdown);

    function updateCountdown() {
        var remaining = 200 - jQuery('#update-status').val().length;
        jQuery('.countdown').text(remaining + ' characters remaining.');
    }
  });
}