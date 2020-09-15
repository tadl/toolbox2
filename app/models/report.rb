class Report < ApplicationRecord
  validates :stat_id, uniqueness: { scope: [:department_id, :report_date] }
end
