class AddGroupToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :group, :string
  end
end
