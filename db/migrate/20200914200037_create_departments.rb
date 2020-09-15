class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :location
      t.boolean :active
      t.string :short_code

      t.timestamps
    end
  end
end
