class FetchSign < ApplicationJob
    require 'open-uri'
    require 'json'
    self.queue_adapter = :sidekiq
  
    def perform
        url = 'https://www.tadl.org/events/feed/json?ongoing_events=show&start=12:00am&end=7day'
        data = JSON.parse(open(url).read) rescue []
        @events = []
        data.each do |e|
          if !e['room'].empty?
            # Only get events for McGuire, thirlby, youth, and teen
            if e['room'].key?('124') || e['room'].key?('125') || e['room'].key?('131') || e['room'].key?('130') || e['room'].key?('162')
              @events.push(e)
            end
          end
        end
        Rails.cache.write('sign_events_last_update', Time.now.to_s)
        Rails.cache.write('sign_events', @events)
        end
    end