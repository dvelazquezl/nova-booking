class AddQuantityToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :quantity, :integer
  end
end
