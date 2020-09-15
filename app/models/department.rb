class Department < ApplicationRecord
  validates :name, :short_code, uniqueness: true
end
