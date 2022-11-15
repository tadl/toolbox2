class CoversController < ApplicationController
  before_action :authenticate_user!
  def home
    @page = 'index'
    @covers = Cover.where(status: 'needs cover').paginate(:page => params[:page], :per_page => 10)
  end

  def new_cover
    @page = 'find'
    @record_id = params[:record_id]
  end

  def not_found
    @page = 'not_found'
    @covers = Cover.where(status: 'not found').paginate(:page => params[:page], :per_page => 10)
  end

  def add_manually
    @page = 'find'
  end

  def load_cover
    @cover = Cover.find_by record_id: params[:record_id]
    if @cover.nil? 
      @cover = Cover.new
      @cover.record_id = params[:record_id]
      @load_data = @cover.get_data
    end
    respond_to do |format|
      format.js
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
