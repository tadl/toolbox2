class Location < ApplicationRecord
    def exceptions
        location_closures = []
        closures = Closure.where('closure_date >= ?', Date.today).order('closure_date ASC')
        closures.each do |c|
            if c.locations.include? self.id.to_s
                closure_info = {}
                closure_info['date'] = c.closure_date
                closure_info['hours'] = c.hours
                closure_info['reason'] = c.reasons
                location_closures.push(closure_info)
            end
        end
        return location_closures
    end

    def as_json(options={})
        options[:methods] = [:exceptions]
        super
    end
end
