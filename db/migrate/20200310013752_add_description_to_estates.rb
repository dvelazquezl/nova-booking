class AddDescriptionToEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :estates, :description, :string
  end
end
