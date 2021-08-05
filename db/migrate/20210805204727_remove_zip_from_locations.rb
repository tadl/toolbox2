class RemoveZipFromLocations < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :zip, :string
  end
end
