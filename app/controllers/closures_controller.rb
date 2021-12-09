class ClosuresController < ApplicationController
    before_action :authenticate_super_user!
    def index
        @closures = Closure.where('closure_date >= ?', Date.today).order('closure_date ASC')
    end

    def new
        @closure = Closure.new
        @locations = Location.all.order('id ASC')
    end

    def save
        if params[:id]
            @closure = Closure.find(params[:id].to_i)
            if @closure
                @closure.update(closure_params)
                @closure.save
            else
                @error = "Unknown closure"
            end
        else
            @closure = Closure.new(closure_params)
            @closure.save
        end
        respond_to do |format|
            format.js
        end
    end

    def edit
        @locations = Location.all.order('id ASC')
        @closure = Closure.find(params[:id])
    end

    def feed
        @closures = Closure.where('closure_date >= ?', Date.today).order('closure_date ASC')
        @closures_by_date = sort_closures_by_date(@closures)
        respond_to do |format|
            format.json {render json: {exceptions: @closures_by_date}}
        end
    end


    def delete
        @closure = Closure.find(params[:id].to_i)
        @closure.destroy
        respond_to do |format|
            format.js
        end
    end

    private
    
    def closure_params
        params.permit(:closure_date, :hours, :reasons, :locations => [])
    end

    def sort_closures_by_date(closures)
        all_dates = []
        @closures.each do |c|
            all_dates.push(c.closure_date)
        end
        closure_group = []
        all_dates.uniq.each do |d|
            closure_info = {}
            closure_info['date'] = d
            closure_info['locations'] = []
            @closures.where(closure_date: d).each do |c|
                c.locations.each do |l|
                    location = {}
                    location['id'] = l.to_i
                    location['hours'] = c.hours
                    location['reason'] = c.reasons
                    closure_info['locations'].push(location)
                end
                closure_group.push(closure_info)
            end
        end
        return closure_group.uniq
    end

end