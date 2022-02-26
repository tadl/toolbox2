class CreateNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :numbers do |t|
      t.string :name
      t.string :phone
      t.string :type

      t.timestamps
    end
  end
end
