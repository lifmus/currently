$(function() {
  $(document).ready(function() {
    $('#update-status').focus();
    $('.fade').fadeOut(4000);

    if (window.location.hash == '#_=_'){
        history.replaceState 
            ? history.replaceState(null, null, window.location.href.split('#')[0])
            : window.location.hash = '';
    }
  });
});

