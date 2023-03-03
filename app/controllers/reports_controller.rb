class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @departments = Department.all.order('name ASC')
  end

  def show_calendar
    @department = Department.find(params[:department_id])
    if params[:start_date] 
      day = Date.parse(params[:start_date])
      @start_date = day.beginning_of_month
      @end_date = day.end_of_month
    else
      day = Date.today
      @start_date = day.beginning_of_month
      @end_date = day.end_of_month
    end
    @reports = Report.where("department_id = ? AND report_date >= ? AND report_date <= ?", @department.id, @start_date, @end_date).to_a
    respond_to do |format|
      format.js
    end
  end
  
  def show_report_form
    @department = Department.find(params[:department_id])
    @date = params[:date]
    report_date = Date.parse params[:date]
    @fancy_date = report_date.strftime("%B %d %Y")
    @reports = Report.where(department_id: @department.id, report_date: report_date).to_a
    respond_to do |format|
      format.js
    end
  end

  def save_report
    @stats = Stat.all
    params.each do |k,v|
      if @stats.pluck(:code).include?(k)
        stat = @stats.where(code: k).take
        report = Report.where(stat_id: stat.id, department_id: params[:department_id], report_date: params[:report_date]).first
        if !report.nil?
          if v != '0'
            report.update(report_params)
            report.value = v
            report.last_edit_by = current_user.email
            report.save
          else
            report.destroy
          end
        elsif v != '0'
          report = Report.new(report_params)
          report.stat_id = stat.id
          report.value = v
          report.last_edit_by = current_user.email
          report.save
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def report_params
    params.permit(:stat_id, :value, :last_edit_by, :department_id, :report_date)
  end

end
