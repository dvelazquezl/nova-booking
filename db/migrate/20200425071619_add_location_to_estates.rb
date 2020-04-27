class AddLocationToEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :estates, :latitude, :decimal
    add_column :estates, :longitude, :decimal
  end
end
