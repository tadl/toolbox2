class CreateTrailers < ActiveRecord::Migration[6.0]
  def change
    create_table :trailers do |t|
      t.integer  :record_id
      t.string   :added_by
      t.string   :youtube_url
      t.string   :release_date
      t.string   :tile
      t.string   :artist
      t.string   :publisher
      t.text     :abstract
      t.string   :title
      t.integer  :user_id
      t.boolean  :cant_find,    default: false
      t.string   :item_type
      t.text     :track_list
      t.timestamps
    end
  end
end
