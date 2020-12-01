class CoversController < ApplicationController
  def home
    @covers = Cover.where(status: 'needs cover').paginate(:page => params[:page], :per_page => 10)
  end

  def new_cover
    @record_id = params[:record_id]
  end

  def not_found
    @covers = Cover.where(status: 'not found').paginate(:page => params[:page], :per_page => 10)
  end

  def add_manually
  end

  def load_cover
    @cover = Cover.find_by record_id: params[:record_id]
    if @cover.nil?
      @cover = Cover.new
      if @cover.manual_load(params[:record_id])
        if @cover.valid? == true
          @cover.save!
        end
        @message = 'success'
      else
        @message = "invalid record id"
      end
    else
      @message = 'success'
    end
  end

  def cover_upload
    @cover = Cover.find_by record_id: params[:record_id]
    if !params[:coverart].nil?
      @cover.coverart = params[:coverart]
      if @cover.valid? == true
        @message = 'success'
        @cover.status = 'has cover'
        @cover.save!
      else
        @message = 'fail'
      end
    elsif params[:remote_coverart_url]
      @cover.remote_coverart_url = params[:remote_coverart_url]
      if @cover.valid? == true
        @message = 'success'
        @cover.status = 'has cover'
        @cover.save!
      else
        @message = 'fail'
      end
    else
      @message = 'You must select an image for upload'
    end
  end

  def mark_not_found
    @cover = Cover.find(params[:id])
    @cover.status = 'not found'
    @cover.save!
  end
end
