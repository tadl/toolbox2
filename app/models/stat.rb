class Stat < ApplicationRecord
  validates :code, uniqueness: true
end
