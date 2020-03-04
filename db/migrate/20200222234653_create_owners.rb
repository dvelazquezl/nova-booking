class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
