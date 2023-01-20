class FetchEvents < ApplicationJob
    require 'open-uri'
    require 'json'
    self.queue_adapter = :sidekiq
  
    def perform
        puts "fetching events..."
        base_url = 'https://www.tadl.org/events/feed/json?ongoing_events=show&start=12:00am&end=1month'
        @venues = [
            { code: 'all', name: 'All'},
            { code: '89', name: 'Traverse City' },
            { code: '132', name: 'East Bay' },
            { code: '133', name: 'Fife Lake' },
            { code: '134', name: 'Kingsley' },
            { code: '135', name: 'Interlochen' },
            { code: '136', name: 'Peninsula' },
            { code: '160', name: 'Online' },
        ]
        @venues.each do |v|
            @events_and_venues = {}
            @events_and_venues['all_venues'] = @venues
            @events_and_venues['current_venue'] = v
            if v['code'] != 'all'
                url = base_url + '&branches=' + v[:code]
            else
                url = base_url
            end 
            @events = []
            events_data = JSON.parse(open(url).read)
            events_data.each do |e|
                event = {}
                event['title'] = e['title']
                event['start_date'] = e['start_date']
                event['location'] = process_location(e['branch'])
                event['image'] = e['image']
                event['url'] = e['url']
                @events.push(event)
            end
            @events_and_venues['events'] = @events
            Rails.cache.write(('events_' + v[:code]), @events_and_venues)
            @test = Rails.cache.fetch(('events_' + v[:code]))
            puts @test.to_s
        end
    end

    private
    
    def process_location(locations)
        location = ''
        i = 0
        locations.each do |k,v|
            i += 1
        end
        if i > 1
            locations.each do |k,v|
                location += v + ', '
            end
        else
            locations.each do |k,v|
               location +=  v
            end 
        end
        return location
    end
  end