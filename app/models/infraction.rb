class Infraction < ApplicationRecord
    validates :description, uniqueness: true
end
