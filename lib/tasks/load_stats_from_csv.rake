desc "load stat types for csv"
task :stats_from_csv => :environment do
  require 'csv'
  require 'open-uri'
  require 'json'
  CSV.foreach("#{Rails.root}/db/stats.csv", :encoding => 'windows-1251:utf-8') do |x|
    stat = Stat.new
    stat.code = x[0]
    stat.name = x[1]
    stat.group_name = x[2]
    stat.start_date = x[3].to_date
    if stat.valid?
      stat.save!
    end
  end
end