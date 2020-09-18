class CreateSoftStatnames < ActiveRecord::Migration[6.0]
  def change
    create_view :soft_statnames
  end
end
