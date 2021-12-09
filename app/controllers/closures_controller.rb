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

end