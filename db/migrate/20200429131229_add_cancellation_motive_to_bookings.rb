class AddCancellationMotiveToBookings < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :cancellation_motive, foreign_key: true
  end
end
