class AddValuesToDepartament < ActiveRecord::Migration[5.2]
  def up
    Departament.create([{name:'Alto Paraguay'},{name:'Alto Paraná'},{name:'Amambay'},{name:'Boquerón'},{name:'Caaguazú'},{name:'Caazapá'},{name:'Canindeyú'},{name:'Central'},{name:'Concepción'},{name:'Cordillera'},{name:'Guairá'},{name:'Itapúa'},{name:'Misiones'},{name:'Ñeembucú'},{name:'Paraguarí'},{name:'Pesidente Hayes'},{name:'San Pedro'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end