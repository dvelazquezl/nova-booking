class CreateEstates < ActiveRecord::Migration[6.0]
  def change
    create_table :estates do |t|
      t.string :name
      t.string :address
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
