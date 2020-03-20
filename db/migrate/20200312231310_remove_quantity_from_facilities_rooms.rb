class RemoveQuantityFromFacilitiesRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :facilities_rooms, :quantity, :integer
  end
end
