class AddFaciltyTypeToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :facility_type, :string
  end
end
