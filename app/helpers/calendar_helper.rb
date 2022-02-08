module CalendarHelper
    def fancy_date(starts_at, ends_at)
        starts_date = starts_at.split('@')[0]
        ends_date = ends_at.split('@')[0]
        starts_time = starts_at.split('@')[1]
        ends_time = ends_at.split('@')[1]
        if Date.strptime(starts_date, '%m/%d/%Y') == Date.current
            starts_date = 'Today'
        end
        if Date.strptime(ends_date, '%m/%d/%Y') == Date.current
            ends_date = 'Today'
        end
        if ends_date == starts_date
            return starts_date + ' ' + starts_time + ' to ' + ends_time
       else
           return starts_date + ' ' + starts_time + ' to ' + ends_date + ' ' + ends_time
       end
    end

    def today_color(starts_at, ends_at)
        starts_date = starts_at.split('@')[0]
        ends_date = ends_at.split('@')[0]
        if (Date.strptime(starts_date, '%m/%d/%Y') == Date.current) || (Date.strptime(ends_date, '%m/%d/%Y') == Date.current)
            return('green')
        end
    end

    def today_or_tomorrow(start_date_raw)
        start_date = start_date_raw.to_datetime
        if start_date.to_date == Date.today
            return "Today"
        elsif start_date.to_date == Date.tomorrow
            return "Tomorrow"
        else
            return start_date.strftime("%A") + ', ' + start_date.strftime("%B") + ' ' + start_date.day.to_s
        end
    end

    def string_to_datetime(date_raw)
        date = date_raw.to_datetime
    end

    def check_for_multiday(start_date, end_date)
        if start_date.to_date != end_date.to_date
            return today_or_tomorrow(end_date)
        else
            return ''
        end
    end

    def show_arrow(room)
        if room == '124'
            return ('<i class="fas fa-arrow-circle-left"></i>').html_safe
        else
            return ('<i class="fas fa-arrow-circle-up"></i>').html_safe
        end 
    end

    def happening_now(start_date, end_date)
        if Time.now >= start_date.to_time && Time.now <= end_date.to_time
            return "green"
        else
            return "black"
        end
    end


end
