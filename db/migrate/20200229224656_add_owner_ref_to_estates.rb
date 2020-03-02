class AddOwnerRefToEstates < ActiveRecord::Migration[5.2]
  def change
    add_reference :estates, :owner, null: false, foreign_key: true
  end
end
