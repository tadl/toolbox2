class AddColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :closures, :closure_date, :date
    add_column :closures, :hours, :string
    add_column :closures, :reasons, :string
    add_column :closures, :locations, :string, array: true, default:[]
  end
end
