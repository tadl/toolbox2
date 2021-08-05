class AddFaxToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :zip, :string
  end
end
