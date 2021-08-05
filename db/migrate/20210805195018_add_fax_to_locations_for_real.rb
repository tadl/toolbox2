class AddFaxToLocationsForReal < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :fax, :string
  end
end
