class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :client_name
      t.string :client_email
      t.datetime :date_start
      t.datetime :date_end
      t.datetime :date_creation
      t.integer :total_amount
      t.boolean :booking_state

      t.timestamps
    end
  end
end
