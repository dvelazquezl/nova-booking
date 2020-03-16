class RemoveQuantityFromFacilitiesEstates < ActiveRecord::Migration[5.2]
  def change
    remove_column :facilities_estates, :quantity, :integer
  end
end
