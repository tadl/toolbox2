class CreateSoftLocations < ActiveRecord::Migration[6.0]
  def change
    create_view :soft_locations
  end
end
