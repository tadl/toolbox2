class CalendarController < ApplicationController
  require 'mechanize'
  
  def index
  end

  def workorders
    unless (params[:code] && params[:code] == ENV['WORKORDER_PW']) || current_user
      url = request.url
      redirect_to ('/auth/google_oauth2?origin=') + url
      return
    end
    @events = Rails.cache.fetch('workorders')
    @last_update = Rails.cache.fetch('workorders_last_update')
    respond_to do |format|
      format.html {render layout: 'calendar'}
      format.json {render json: {events: @events, last_update: @last_update}}
    end
  end

  def sign
    @events = Rails.cache.fetch('sign_events')
    respond_to do |format|
      format.html {render layout: 'calendar'}
      format.json {render json: {events: @events}}
    end
  end

  def featured
    if params[:count]
      count = params[:count].to_i
    else
      count = 100
    end
    agent = Mechanize.new
    page = agent.get('https://live-traversearea.pantheonsite.io/events/month')
    event_blocks = page.css('.lc-featured-event')
    @events = []
    event_blocks.first(count).each do |e|
      event = {}
      event['title'] = e.css('h2').text.strip
      event['date'] = e.css('.lc-featured-event-date').text.strip.gsub("\n",'').split(' at ')[0].strip
      event['start_time'] = e.css('.lc-event-info-item--time').text.strip.split(' - ')[0]
      event['end_time'] = e.css('.lc-event-info-item--time').text.strip.split(' - ')[1]
      event['url'] = e.css('.lc-featured-event-btn').attr('href').text rescue nil
      event['image'] = e.css('.lc-featured-event-image img').attr('src').text rescue nil
      unless event['image'].nil?
        @events.push(event)
      end
    end
    respond_to do |format|
      format.json {render json: {events: @events}}
    end
  end

  private 

  def login(username, password)
    agent = Mechanize.new
    agent.get('https://www.tadl.org/user')
    puts agent.page.title
    login_form = agent.page.forms[2]
    login_form.field_with(:name => "name").value = username
    login_form.field_with(:name => "pass").value = password
    agent.submit(login_form)
    page = agent.page
    return agent, page
  end

  def get_setup_notes(url)
    agent = Mechanize.new
    agent.get('https://www.tadl.org/user')
    login_form = agent.page.forms[2]
    login_form.field_with(:name => "name").value = ENV['LIBCAL_USERNAME']
    login_form.field_with(:name => "pass").value = ENV['LIBCAL_PASSWORD']
    agent.submit(login_form)
    page = agent.get('https://www.tadl.org' + url)
    return page.css('div[class*=setup-notes]').map(&:text).join.strip.gsub('Room Setup Notes:','')
  end

end