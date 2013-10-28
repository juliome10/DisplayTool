class CreaTablaCamposFormatosSubformatos < ActiveRecord::Migration
  def up
    create_table 'campos_formatos_subformatos' do |tabla|
      tabla.column :campos_formatos_formato_id, :integer
      tabla.column :campos_formatos_campo_id, :integer
      tabla.column :campos_formato_id, :integer
      tabla.column :subformato_id, :integer
      tabla.float :posicionX
      tabla.float :posicionY
      tabla.float :lonxitudeX
      tabla.float :lonxitudeY
    end
  end

  def down
    drop_table 'campos_formatos_subformatos'
  end
end
