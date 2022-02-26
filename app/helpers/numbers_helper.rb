module NumbersHelper
    def number_type_helper(number_type, select_value)
        if number_type == select_value
            return 'selected'
        end 
    end
end