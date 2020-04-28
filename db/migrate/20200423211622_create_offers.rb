class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :estate, foreign_key: true
      t.string :description
      t.date :date_start
      t.date :date_end
      t.date :date_creation

      t.timestamps
    end
  end
end
