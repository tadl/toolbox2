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

end
