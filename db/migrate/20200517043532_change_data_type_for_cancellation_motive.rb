class ChangeDataTypeForCancellationMotive < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :cancellation_motive, :string
  end
end
