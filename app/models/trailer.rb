class Trailer < ApplicationRecord
   validates :record_id, uniqueness: true
end
