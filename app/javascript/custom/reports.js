window.reports_department_changed = function(){
  var form_date = $('#report_date').text()
  var department_id = $('#department').val()
  if(department_id != 'none'){
    if(form_date){
      $.post("/reports/show_report_form",{date: form_date, department_id: department_id})
      $.post("/reports/show_calendar.js", {start_date: form_date, department_id: department_id})
    }else{
      $.post("/reports/show_calendar.js", {department_id: department_id})
    }
  }else{
    $('#calendar').html('')
    $('#report_form').html('')
  }
}


window.reports_submitt = function(){
  var bad_data = false
  var department_id = $('#department').val()
  var report_date = $.trim($('#report_date').text())
  var params = {}
  var report_inputs = $("#report_form :input")
  $.each(report_inputs, function(){
    $(this).css('border','1px solid #ccc')
    var field_name = this.id
    var field_val = $(this).val()
    //check for whole numbers
    if(!field_val.match(/^[0-9]*$/)){
      $(this).css('border','2px solid red')
      bad_data = true
    }
    if(bad_data == false)
    if(field_val){
      params[field_name] = field_val
    }else{
      params[field_name] = 0
    }
  });
  if(bad_data == true){
    alert('bad data')
  }else{
    params['report_date'] = report_date
    params['department_id'] = department_id
    $.post("save_report", params)
  }
}