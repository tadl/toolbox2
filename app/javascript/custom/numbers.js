window.save_number = function(id){
    var number = {}
    if(id){
        number['id'] = id
    }
    number['name'] = $('#name').val()
    number['phone'] = $('#phone').val()
    number['number_type'] = $('#number_type').val()

    if((number['name'] != ''
        && number['phone'] != '' 
        && number['type'] != '')){
            $.post( "/numbers/save.js", number);
    }else{
        alert('Missing Required Data')
    }
}

window.update_people_numbers = function(){
    var cookies = {}
    cookies['cookie_1'] = $('#cookie_1').val()
    cookies['cookie_2'] = $('#cookie_2').val()
    $.post( "/numbers/staff_portal_load.js", cookies);
}