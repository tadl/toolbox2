desc "Load legacy location data"
task :load_legacy_location_data => :environment do
    require 'csv'
    require 'open-uri'
    require 'json'
    records = Trailer.all
    url = 'https://www.tadl.org/wp-content/uploads/json/parsed-hours.json'
    response = JSON.parse(open(url).read) rescue nil
    response["locations"].each do |l|
        location = Location.new
        location.shortname = l['shortname']
        location.fullname = l['fullname']
        location.sunday = l['sunday']
        location.monday = l['monday']
        location.tuesday = l['tuesday']
        location.wednesday = l['wednesday']
        location.thursday = l['thursday']
        location.friday = l['friday']
        location.saturday = l['saturday']
        location.address = l['address']
        location.citystatezip = l['citystatezip']
        location.phone = l['phone']
        location.fax = l['fax']
        location.email = l['email']
        location.image = l['image']
        location.save! 
    end
end