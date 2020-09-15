class ReportsController < ApplicationController
  def index
    @departments = Department.all
  end

  def show_calendar
    @department = Department.find(params[:department_id])
    if params[:start_date]
        day = Date.parse(params[:start_date])
    else
        day = Date.today
    end
    start_date = Date.new(day.year, day.month - 1, 1).to_date
    end_date = Date.new(day.year, day.month + 1, -1).to_date
    @reports = Report.where("department_id = ? AND report_date >= ? AND report_date <= ?", @department.id, start_date, end_date).to_a
    respond_to do |format|
      format.js
    end
  end
  
  def show_report_form
    @department = Department.find(params[:department_id])
    @date = params[:date]
    report_date = Date.parse params[:date]
    @reports = Report.where(department_id: @department.id, report_date: report_date).to_a
    respond_to do |format|
      format.js
    end
  end

  def about
  end

end
