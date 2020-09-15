window.reports_department_changed = function(){
  var form_date = $('#form_date').text()
  var department_id = $('#department').val()
  if(department_id != 'none'){
    if(form_date){
      $.post("show_report_form",{date: form_date, department_id: department_id})
      $.post("show_calendar.js", {start_date: form_date, department_id: department_id})
    }else{
      $.post("show_calendar.js", {department_id: department_id})
    }
  }else{
    $('#calendar').html('')
    $('#report_form').html('')
  }
}