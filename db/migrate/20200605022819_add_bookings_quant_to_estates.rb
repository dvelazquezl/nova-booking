class AddBookingsQuantToEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :estates, :bookings_quant, :integer, default: 0
  end
end
