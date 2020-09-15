class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.string :code
      t.string :name
      t.string :group_name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
