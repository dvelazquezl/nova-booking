class AddEstateToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :estate, null: false, foreign_key: true
  end
end
