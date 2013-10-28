class CreaTablaCamposFormatos < ActiveRecord::Migration
  def up
    create_table 'campos_formatos' do |tabla|
      tabla.column :formato_id, :integer
      tabla.column :campo_id, :integer
    end
  end

  def down
    drop_table 'campos_formatos'
  end
end
