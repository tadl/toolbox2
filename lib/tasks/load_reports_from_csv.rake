desc "load legacy reports from csv"
task :reports_from_csv => :environment do
  require 'csv'
  require 'json'

  def map_department(value)
    map_array = [['wood-admin','Administration'],
    ['wood-ref','Adult/Reference'],
    ['wood-ill','Interlibrary Loan'],
    ['wood-lbph','Talking Book Library'],
    ['wood-ss','Sight and Sound'],
    ['wood-teen','Teen Services'],
    ['wood-youth','Youth Services'],
    ['wood-proc','Technical Services'],
    ['ebb','East Bay'],
    ['kbl','Kingsley'],
    ['law','Law Library']]
    map_array.each do |m|
      if m[0] == value
        department = Department.where(:name => m[1]).first
        return department.id  
      end
    end
  end

  def map_stat(value)
    stat = Stat.where(:code => value).first
    return stat.id
  end

  CSV.foreach("#{Rails.root}/db/reports.csv", :encoding => 'windows-1251:utf-8') do |x|
    puts 'working on ' + x[0] + ' ' + x[5]
    if x[6].to_i != 0
      report = Report.new
      report.report_date = DateTime.strptime(x[0], '%m/%d/%Y').to_date
      report.created_at =  DateTime.strptime(x[1], '%m/%d/%Y %H:%M').to_time
      report.updated_at =  DateTime.strptime(x[2], '%m/%d/%Y %H:%M').to_time
      report.department_id = map_department(x[3])
      report.last_edit_by = x[4]
      report.stat_id = map_stat(x[5])
      report.value = x[6].to_i
      report.save!
    end
  end
end