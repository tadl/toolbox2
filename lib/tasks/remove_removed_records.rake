desc "Remove trailers that are no longer in Evergreen"
task :remove_removed => :environment do
    require 'csv'
    require 'open-uri'
    require 'json'
    records = Trailer.all
    bad_records = []
    records.each do |r|
        url = 'https://catalog.tadl.org/main/details.json?id=' + r.record_id.to_s
        response = JSON.parse(open(url).read) rescue nil
        if response == nil
            puts 'bad ' + r.title + ' ' + r.record_id.to_s
            r.destroy
        else
            puts 'good ' + r.title
        end
    end
end