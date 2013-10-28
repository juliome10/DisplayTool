class CreaTablaSubformatos < ActiveRecord::Migration
  def up
    create_table :subformatos do |tabla|
      tabla.references :formato, :on_delete => :cascade
      tabla.references :dispositivoloxico, :on_delete => :cascade
    end
  end

  def down
    drop_table :subformatos
  end
end
