class AddConfirmationTokenToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :confirmation_token, :string
    add_column :bookings, :confirmed_at, :datetime
  end
end
