class CreaTablaCamposFormatosSubformatosDiapositivas < ActiveRecord::Migration
  def up
    create_table 'campos_formatos_subformatos_diapositivas' do |tabla|
      tabla.column :campos_formatos_subformatos_campos_formatos_formato_id, :integer
      tabla.column :campos_formatos_subformatos_campos_formatos_campo_id, :integer
      tabla.column :campos_formatos_subformatos_subformato_id, :integer
      tabla.column :campos_formatos_subformato_id, :integer
      tabla.column :diapositiva_id, :integer
      tabla.string :contido, :limit => 1000
    end
  end

  def down
    drop_table 'campos_formatos_subformatos_diapositivas'
  end
end
