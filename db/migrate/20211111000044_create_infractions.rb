class CreateInfractions < ActiveRecord::Migration[6.0]
  def change
    create_table :infractions do |t|
      t.string :description
      t.string :first_offence
      t.string :second_offence
      t.string :subsiquent_offence
      t.string :track

      t.timestamps
    end
  end
end
