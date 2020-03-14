class CreateBookingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_details do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :quantity
      t.integer :subtotal

      t.timestamps
    end
  end
end
