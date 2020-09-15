desc "load departments types for csv"
task :departments_from_csv => :environment do
  require 'csv'
  require 'open-uri'
  require 'json'
  CSV.foreach("#{Rails.root}/db/departments.csv", :encoding => 'windows-1251:utf-8') do |x|
    department = Department.new
    department.name = x[0]
    department.location = x[1]
    department.short_code = x[3]
    if x[2] == 'TRUE'
      department.active = true
    else
      department.active = false
    end
    department.save!
  end
end