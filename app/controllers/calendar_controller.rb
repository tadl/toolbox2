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
    request = login(ENV['LIBCAL_USERNAME'],ENV['LIBCAL_PASSWORD'])
    agent = request[0]
    page = request[1]
    report_page = agent.get('https://tadl.org/admin/reports/calendar/events?title=&field_lc_reservation_state_target_id_op=or&status=All&uid=&created%5Bmin%5D=&created%5Bmax%5D=&field_lc_event_date_value%5Bmin%5D=Today&field_lc_event_date_value%5Bmax%5D=30+days&field_lc_room_target_id%5B%5D=124&field_lc_ignore_conflicts_value=All&field_lc_contact_name_value=&field_lc_contact_email_value=&field_lc_contact_phone_value=&field_lc_people_in_attendance_value=All&sort_by=field_lc_event_date_value&sort_order=ASC')
    event_table = report_page.css('.views-table').css('tbody')
    @events = []
    event_table.css('tr').first(5).each do |r|
      e = {}
      e['title'] = r.css('.views-field-title').text.strip
      e['url'] = r.css('.views-field-title').css('a').attr('href').value
      e['starts_at'] = r.css('.views-field-field-lc-event-date').text.strip
      e['ends_at'] = r.css('.views-field-field-lc-event-date-1').text.strip
      e['room_setup'] = r.css('.views-field-field-lc-room-setup').text.strip.split("\n")[0]
      e['room_setup_picture'] = 'https://live-traversearea.pantheonsite.io/' + r.search('.views-field-field-lc-room-setup img')[0].attr('src') rescue nil
      e['room_setup_notes'] = get_setup_notes(e['url'])
      e['expected_attendance'] = r.css('.views-field-field-lc-expected-attendance').text.strip
      e['contact_name'] = r.css('.views-field-field-lc-contact-name').text.strip
      e['contact_email'] = r.css('.views-field-field-lc-contact-email').text.strip
      e['contact_phone'] = r.css('.views-field-field-lc-contact-phone').text.strip
      e['contact_organization'] = r.css('.views-field-field-lc-organization').text.strip
      e['presenter'] = r.css('.views-field-field-lc-presenter').text.strip
      e['av_required'] = r.css('.views-field-field-lc-av-equipment-needed').text.strip
      e['equipment_needed'] = r.css('.views-field-field-lc-equipment-available').text.strip
      e['description'] = r.css('.views-field-field-lc-program-description').text.strip
      e['summary'] = r.css('.views-field-body-1').text.strip
      e['body'] = r.css('.views-field-body').text.strip
      e['state'] = r.css('.views-field-field-lc-reservation-state').text.strip
      @events.push(e)
    end
    respond_to do |format|
      format.html {render layout: 'calendar'}
      format.json {render json: {events: @events}}
    end
  end

  def sign
    url = 'https://live-traversearea.pantheonsite.io/events/feed/json?ongoing_events=show&start=12:00am'
    data = JSON.parse(open(url).read)
    @events = []
    data.each do |e|
      if !e['room'].empty?
        # Only get events for McGuire, thirlby, youth, and teen
        if e['room'].key?('124') || e['room'].key?('125') || e['room'].key?('131') || e['room'].key?('130') || e['room'].key?('162')
          @events.push(e)
        end
      end
    end
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