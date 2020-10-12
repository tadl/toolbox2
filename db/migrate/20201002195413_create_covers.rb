class CreateCovers < ActiveRecord::Migration[6.0]
  def change
    create_table :covers do |t|
      t.integer :record_id
      t.string :source
      t.integer :staff_id
      t.string :status
      t.text :title
      t.text :artist
      t.string :publisher
      t.string :release_date
      t.string :item_type
      t.text :track_list
      t.text :abstract
      t.string :coverart

      t.timestamps
    end
  end
end
