class Trailer < ApplicationRecord
  validates :record_id, uniqueness: true
  require 'open-uri'
  require 'json'
  require 'googleauth'
  require 'google/apis/youtube_v3'

  def get_data
    url = 'https://catalog.tadl.org/osrf-gateway-v1?service=open-ils.search&method=open-ils.search.biblio.record.mods_slim.retrieve&locale=en-US&param=' + self.record_id.to_s
    puts url
    record_details = JSON.parse(open(url).read)
    if record_details["payload"][0]['__p']
      self.title = record_details['payload'][0]['__p'][0]
      self.artist = record_details['payload'][0]['__p'][1]
      self.record_id = record_details['payload'][0]['__p'][2]
      self.release_date = record_details['payload'][0]['__p'][4]
      self.abstract = record_details['payload'][0]['__p'][13]
      self.publisher = record_details['payload'][0]['__p'][6]
      self.track_list = record_details['payload'][0]['__p'][15]
      self.item_type = record_details['payload'][0]['__p'][9][0]
      if self.valid?
        self.save!
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def check_youtube
    client = Google::Apis::YoutubeV3::YouTubeService.new
    auth = Google::Auth::ServiceAccountCredentials.make_creds(
      scope: ['https://www.googleapis.com/auth/youtube']  
    )
    client.authorization = auth
    verification = client.list_videos('status', id: self.youtube_url)
    if verification.items[0]
      if verification.items[0].status.embeddable == true
        @status = self.update_trailer
      else
        @status = 'This trailer is non embeddable'
      end
    else
        @status = 'Invalid Youtube ID'
    end
  end

  # Just like method above, but for use in rake task
  def just_check_youtube
    client = Google::Apis::YoutubeV3::YouTubeService.new
    auth = Google::Auth::ServiceAccountCredentials.make_creds(
      scope: ['https://www.googleapis.com/auth/youtube']  
    )
    client.authorization = auth
    verification = client.list_videos('status', id: self.youtube_url)
    if verification.items[0]
      if verification.items[0].status.embeddable == true
        return true
      else
        return false
      end
    else
        return false
    end
  end

  def update_trailer()
    self.cant_find = false
    if self.valid?
      self.save!
      return 'Trailer was successfully updated'
    else
      return 'Invalid Trailer'
    end
  end

end