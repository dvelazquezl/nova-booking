class AddDiscountToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :discount, :integer
  end
end
