class RemoveCancellationMotiveFromBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :cancellation_motive_id
  end
end
