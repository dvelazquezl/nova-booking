class CreateFacilitiesEstates < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities_estates, :id => false do |t|
      t.references :facility
      t.references :estate
      t.integer :quantity
    end
  end
end
