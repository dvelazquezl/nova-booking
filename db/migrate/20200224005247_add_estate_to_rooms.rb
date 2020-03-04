class AddEstateToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :estate, null: false, foreign_key: true
  end
end
