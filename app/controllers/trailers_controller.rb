class TrailersController < ApplicationController
  require 'googleauth'
  require 'google/apis/youtube_v3'

  def index
    @trailers = Trailer.last(10)
  end

  def verify
    if params[:id]
      youtube_id = params[:id]
      verification = check_trailer(youtube_id)
      if verification.items[0]
        if verification.items[0].status.embeddable == true
          status = 'valid'
        else
          status = 'embeddable_false'
        end
      else
        status = 'invalid_youtube_id'
      end
    else
      status = 'no_id'
    end
    respond_to do |format|
      format.js
      format.json {render json: status}
    end
  end

  private

  def check_trailer(youtube_id)
    client = Google::Apis::YoutubeV3::YouTubeService.new
    auth = Google::Auth::ServiceAccountCredentials.make_creds(
      scope: ['https://www.googleapis.com/auth/youtube']  
    )
    client.authorization = auth
    client.list_videos('status', id: youtube_id)
  end

end
