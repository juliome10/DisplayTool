class CreaTablaCamposEstilos < ActiveRecord::Migration
  def up
    create_table 'campos_estilos' do |tabla|
      tabla.column :campo_id, :integer
      tabla.column :estilo_id, :integer
      tabla.string :fonte
      tabla.string :tamano
      tabla.string :cor
      tabla.string :alinadoHorizontal
      tabla.string :alinadoVertical
    end
  end

  def down
    drop_table 'campos_estilos'
  end
end