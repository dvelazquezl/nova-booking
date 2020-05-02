class ChangeScoreToBeDecimalInEstates < ActiveRecord::Migration[5.2]
  def change
      change_column :estates, :score, :decimal
  end
end
