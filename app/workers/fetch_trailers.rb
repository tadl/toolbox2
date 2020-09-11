class FetchTrailers < ApplicationJob
  require 'open-uri'
  require 'json'
  self.queue_adapter = :sidekiq



  def perform
    page = 0
    while page <= 2
      catalog_url = 'https://catalog.tadl.org/search.json?qtype=keyword&fmt=g&sort=pubdateDESC&page=' + page.to_s
      catalog_data = JSON.parse(open(catalog_url).read)
      catalog_data["items"].each do |item|
        puts item["title"]
        t = Trailer.new
        t.record_id = item["id"].to_s
        t.title = item["title"].to_s
        t.artist = item["author"].to_s
        t.abstract = item["abstract"].to_s
        t.release_date = item["record_year"].to_s
        t.publisher = item["publisher"].to_s
        t.track_list = item["contents"].to_s
        t.item_type = item["format_type"].to_s
        if t.valid? == true
          t.save!
        end
      end
      page +=1
    end
  end
end