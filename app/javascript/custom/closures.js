window.save_closure = function(id){
    var closure = {}
    if(id){
        closure['id'] = id
    }
    closure['closure_date'] = $('#date').val()
    closure['hours'] = $('#hours').val()
    closure['reasons'] = $('#reason').val()
    closure['locations'] = []
    $('[name="locations[]"]').each(function() {
        if ($(this).is(':checked')){
            closure['locations'].push($(this).val())
        }    
    });
    if((closure['closure_date'] != ''
        && closure['hours'] != '' 
        && closure['reasons'] != '')
        && closure['locations'].length >= 1){
            $.post( "/closures/save.js", closure );
    }else{
        alert('Missing Required Data')
    }
}