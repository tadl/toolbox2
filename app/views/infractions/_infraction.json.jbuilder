json.extract! infraction, :id, :description, :first_offence, :second_offence, :subsiquent_offence, :track, :created_at, :updated_at
json.url infraction_url(infraction, format: :json)
