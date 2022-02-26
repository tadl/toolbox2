class NumbersController < ApplicationController
    require 'mechanize'

    def index
        @numbers = Number.all
    end
    def new
        @number = Number.new
    end

    def edit
        @number = Number.find(params[:id])
    end

    def save
        if params[:id]
            @number = Number.find(params[:id].to_i)
            if @number
                @number.update(number_params)
                @number.save
            else
                @error = "Unknown number"
            end
        else
            @number = Number.new(number_params)
            @number.save
        end
        respond_to do |format|
            format.js
        end
    end

    def directory
        respond_to do |format|
            format.xml
        end
    end

    def update_people
        respond_to do |format|
            format.html
        end
    end

    def staff_portal_load 
        @staff = numbers_from_staff_portal(params[:cookie_1], params[:cookie_2])
        unless @staff == 'error: invalid cookies' || @staff.empty?
            Number.where(number_type: 'people').destroy_all
            @staff.each do |s|
                staff = Number.new
                staff.name = s[:name]
                staff.phone = s[:phone]
                staff.number_type='people'
                staff.save!
            end
        end
        respond_to do |format|
            format.json {render json: {staff: @staff}}
            format.js
        end
    end

    def numbers_for
        @numbers = number_type(params[:value])
        @title = directory_title(params[:value]) 
        respond_to do |format|
            format.json {render json: {numbers: @numbers}}
            format.xml
        end
    end

    def destroy
    end

    private
    
    def number_params
        params.permit(:name, :phone, :number_type)
    end

    def directory_title(value)
        if value == "help"
            return 'Get Help'
        elsif value == "branch"
            return 'Branch & Members'
        elsif value == "desk"
            return 'Desks & Departments'
        elsif value == "peopleAL"
            return 'People A - L'
        elsif value == "peopleMZ"
            return 'People M - Z'
        end
    end

    def number_type(value)
        if value != 'peopleAL' && value != 'peopleMZ'
            numbers = Number.where(number_type: value).order('name ASC')
        else
            if value == 'peopleAL'
                letter_range = ('A'..'L').to_a
                numbers = Number.where(number_type: 'people').where("substr(name, 1, 1) IN (?)", letter_range)
            elsif value == 'peopleMZ'
                letter_range = ('M'..'Z').to_a
                numbers = Number.where(number_type: 'people').where("substr(name, 1, 1) IN (?)", letter_range)
            end
        end
        return numbers
    end

    def numbers_from_staff_portal(cookie_1, cookie_2)
        agent = Mechanize.new

        cookie = Mechanize::Cookie.new(ENV['STAFF_COOKIE_1'], cookie_1)
        cookie.domain = 'staff.tadl.org'
        cookie.path = '/'
        agent.cookie_jar.add!(cookie)

        cookie = Mechanize::Cookie.new(ENV['STAFF_COOKIE_2'], cookie_2)
        cookie.domain = 'staff.tadl.org'
        cookie.path = '/'
        agent.cookie_jar.add!(cookie)

        url = 'https://staff.tadl.org/staff-directory/'

        page = agent.get(url)

        if page.title == 'Sign in - Google Accounts'
            return 'error: invalid cookies'
            escape
        end


        staff_array = []

        page.parser.css('.individual').each do |h|
            staff = {}
            staff[:name] = h.css('.family-name').text + ', ' + h.css('.given-name').text
            staff[:location] = h.css('.organization-name').text
            work_phone_numbers = []
            h.css('.tel').each do |t|
                if t.css('.phone-name').text == 'Work Phone'
                    work_phone_numbers.push(t.css('.value').text)
                end
            end
            if work_phone_numbers.count > 1
                work_phone_numbers.each do |n|
                    if n.include? 'ext'
                        staff[:phone] = n.gsub('ext','')
                    end
                end
            else
                staff[:phone] = work_phone_numbers.first
            end
            if staff[:location] != 'Peninsula Community Library' && staff[:location] != 'Interlochen Public Library' && staff[:location] != 'Fife Lake Public Library' && staff[:phone]
                staff_array.push(staff)
            end
        end
        return staff_array
    end

end