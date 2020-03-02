class CreateFacilitiesRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities_rooms, :id => false do |t|
      t.references :facility
      t.references :room
      t.integer :quantity
    end
  end
end
