class CreateFacilitiesRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities_rooms, :id => false do |t|
      t.references :facility
      t.references :room
      t.integer :quantity
    end
  end
end
