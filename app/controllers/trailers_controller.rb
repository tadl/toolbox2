class TrailersController < ApplicationController
  require 'googleauth'
  require 'google/apis/youtube_v3'
  before_action :set_headers
  before_action :authenticate_user!, :except => [:get_trailer]

  def index
    @page = 'index'
    @trailers = Trailer.where(youtube_url: nil).where(cant_find: false).order("id DESC").paginate(page: params[:page], per_page: 10)
  end

  def not_found
    @page = 'not_found'
    @trailers = Trailer.where(youtube_url: nil).where(cant_find: true).order("id DESC").paginate(page: params[:page], per_page: 10)
  end

  def find
    @record_id = params[:record_id]
    @page = 'find'
    @trailer = Trailer.where(record_id: @record_id).first
    if !@record_id.nil? && @record_id != ''
      if @trailer
        @status = 'success'
      else
        @trailer = Trailer.new
        @trailer.record_id = @record_id
        add_trailer = @trailer.get_data
        if add_trailer == true
          @status = 'success'
        else
          @status = 'no_record'
        end
      end
    else
      @status = 'no_id'
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def get_trailer
    record_id = params[:id]
    trailer = Trailer.where(record_id: record_id).first
    if trailer
      @message = trailer.youtube_url
    else
      @message = 'error'
    end
    respond_to do |format|
      format.json {render json: {message: @message}}
    end
  end

  def verify
    if params[:id] && params[:record_id]
      youtube_id = params[:id]
      @record_id = params[:record_id]
      trailer = Trailer.where(record_id: @record_id).first
      if trailer.nil?
        trailer = Trailer.new
      end
      trailer.record_id = @record_id
      trailer.youtube_url = youtube_id
      @status = trailer.check_youtube
    else
      @status = 'Invalid parameters'
    end
    respond_to do |format|
      format.js
      format.json {render json: status}
    end
  end

  def mark_not_found
    @record_id = params[:record_id]
    trailer = Trailer.where(record_id: @record_id).first
    if trailer
      trailer.cant_find = true
      trailer.save!
      @status = 'success'
    else
      @status = 'error'
    end
    respond_to do |format|
      format.js
      format.json {render json: status}
    end
  end

  def remove_current_trailer
    @record_id = params[:record_id]
    trailer = Trailer.where(record_id: @record_id).first
    if trailer
      trailer.youtube_url = nil
      trailer.save!
      @status = 'success'
    else
      @status = 'error'
    end
    respond_to do |format|
      format.js
      format.json {render json: status}
    end
  end

end
