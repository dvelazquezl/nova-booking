class AddStatusToEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :estates, :status, :boolean, default: false, null: false
  end
end
