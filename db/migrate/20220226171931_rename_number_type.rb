class RenameNumberType < ActiveRecord::Migration[6.0]
  def change
    add_column :numbers, :number_type, :string
  end
end
