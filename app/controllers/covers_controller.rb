class CoversController < ApplicationController
  before_action :authenticate_user!
  def home
    @page = 'index'
    @covers = Cover.all
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
    if params[:record_id] != ""
      @cover = Cover.where(record_id: params[:record_id]).first
      if @cover.nil? && !params[:record_id].nil?
        @cover = Cover.new
        @cover.record_id = params[:record_id]
        load_data = @cover.get_data
      end
      if load_data == false
        @error = "Invalid record ID"
      end
    else
      @error = "Please enter a record ID"
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
