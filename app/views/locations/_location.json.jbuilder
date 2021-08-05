json.extract! location, :id, :shortname, :fullname, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :address, :citystatezip, :phone, :email, :image, :created_at, :updated_at
json.url location_url(location, format: :json)
