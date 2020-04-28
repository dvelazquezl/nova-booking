class AddDefaultValuesToScoreToEstate < ActiveRecord::Migration[5.2]
  def change
    change_column :estates, :score, :integer, default: 0
  end
end
