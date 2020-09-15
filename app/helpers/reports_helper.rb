module ReportsHelper
  
  def check_for_value(code, reports)
    stat_id = Stat.where(code: code).first.id
    report = reports.detect{|r| r.stat_id == stat_id}
    if !report.nil?
      return report.value
    end
  end

  def check_for_report_on_date(date, reports)
    report = reports.detect{|r| r.report_date.to_s == date}
    if !report.nil?
      return '; font-weight: 900; font-size: 14px;'
    else
      return nil
    end
  end

end