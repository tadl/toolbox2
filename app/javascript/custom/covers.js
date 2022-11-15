window.find_cover = function find_cover(){
    var record_id = $("#cover_search").val()
    $('#alerts').html('')
    $.post( "/covers/load_cover.js", {record_id: record_id } );
}