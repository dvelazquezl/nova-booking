class AddValuesToFacility < ActiveRecord::Migration[5.2]
  def up
    Facility.create([{description: 'Jacuzzi', facility_type: 'room'},
                     {description: 'TV', facility_type: 'room'},
                     {description: 'Wifi', facility_type: 'estate'},
                     {description: 'Minibar', facility_type: 'room'},
                     {description: 'Cocina', facility_type: 'room'},
                     {description: 'Balcon', facility_type: 'room'},
                     {description: 'A/C', facility_type: 'room'},
                     {description: 'Caja fuerte', facility_type: 'room'},
                     {description: 'Escritorio', facility_type: 'room'},
                     {description: 'Lavadero', facility_type: 'room'},
                     {description: 'Sofa', facility_type: 'room'},
                     {description: 'Alberca', facility_type: 'estate'},
                     {description: 'Bar', facility_type: 'estate'},
                     {description: 'Desayuno', facility_type: 'estate'},
                     {description: 'Mesa de billar', facility_type: 'estate'},
                     {description: 'Estacionamiento', facility_type: 'estate'},
                     {description: 'SPA', facility_type: 'estate'},
                     {description: 'GYM', facility_type: 'estate'},
                     {description: 'Restaurante', facility_type: 'estate'},
                     {description: 'Sauna', facility_type: 'estate'}])

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
