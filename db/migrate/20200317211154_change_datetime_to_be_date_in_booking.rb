class ChangeDatetimeToBeDateInBooking < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :date_start, :date
    change_column :bookings, :date_creation, :date
    change_column :bookings, :date_end, :date
  end
end
