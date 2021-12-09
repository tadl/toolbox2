module ClosuresHelper
    def location_id_to_fullname(id)
        location= Location.find(id.to_i)
        return location.fullname + ','
    end

    def check_location(id, closure)
        if closure.locations.include? id.to_s
            return 'checked'
        end
    end
end
