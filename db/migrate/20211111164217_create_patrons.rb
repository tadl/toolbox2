class CreatePatrons < ActiveRecord::Migration[6.0]
  def change
    create_table :patrons do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.boolean :no_name
      t.string :card_number
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.boolean :no_address
      t.text :physical_description
      t.string :alias
      t.json :patronpic

      t.timestamps
    end
  end
end
