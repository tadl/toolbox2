class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :stat_id
      t.integer :value
      t.string :last_edit_by
      t.integer :department_id
      t.date :report_date

      t.timestamps
    end
  end
end
