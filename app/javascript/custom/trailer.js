window.save_trailer = function(record_id) {
  var div_to_hide = '#form_' + record_id
  $(div_to_hide).hide() 
  var target_div = '#trailer_url_' + record_id
  var url = $(target_div).val()
  if(url.startsWith("https://www.youtube.com/watch?v=")){
    var youtube_id = url.replace('https://www.youtube.com/watch?v=','')
    $.post( "/trailers/verify.js", { id: youtube_id, record_id: record_id } );
  }else{
    var alert_div = '#alerts_' + record_id
    $(alert_div).html('<div class="alert alert-danger" role="alert">Not a valid Youtube URL</div>')
    $(div_to_hide).show() 
  }
}