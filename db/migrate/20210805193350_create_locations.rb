class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :shortname
      t.string :fullname
      t.string :sunday
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :address
      t.string :citystatezip
      t.string :phone
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
