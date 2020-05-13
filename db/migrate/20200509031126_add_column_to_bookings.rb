class AddColumnToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :cancellation_motive, :string
  end
end
