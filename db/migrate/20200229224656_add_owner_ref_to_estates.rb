class AddOwnerRefToEstates < ActiveRecord::Migration[6.0]
  def change
    add_reference :estates, :owner, null: false, foreign_key: true
  end
end
