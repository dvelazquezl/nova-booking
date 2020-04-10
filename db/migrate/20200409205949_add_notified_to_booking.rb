class AddNotifiedToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :notified, :boolean
  end
end
