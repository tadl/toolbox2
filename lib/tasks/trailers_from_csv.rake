desc "Load trailers via CSV"
task :trailers_from_csv => :environment do
  require 'csv'
  require 'open-uri'
  require 'json'
  CSV.foreach("#{Rails.root}/db/trailers.csv", :encoding => 'windows-1251:utf-8') do |x|
    trailer = Trailer.new
    trailer.record_id = x[0]
    trailer.youtube_url = x[2]
    trailer.added_by = x[3]
    trailer.cant_find = x[4]
    trailer.title = x[5]
    trailer.artist = x[6]
    trailer.publisher = x[7]
    trailer.release_date = x[8]
    trailer.abstract = x[9]
    trailer.track_list = x[10]
    trailer.item_type = x[11]
    if trailer.valid?
      trailer.save!
    end
  end
end