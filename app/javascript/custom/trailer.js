window.save_trailer = function(record_id) { 
  var target_div = '#trailer_url_' + record_id
  var url = $(target_div).val()
  if(url.startsWith("https://www.youtube.com/watch?v=")){
    var youtube_id = url.replace('https://www.youtube.com/watch?v=','')
    $.post( "/trailers/verify.js", { id: youtube_id, record_id: record_id } );
  }else{
    alert('not a valid url')
  }
}