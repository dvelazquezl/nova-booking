class CreateOfferDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_details do |t|
      t.references :room, foreign_key: true
      t.integer :discount

      t.timestamps
    end
  end
end
