class CreaTablaDispositivofisicos < ActiveRecord::Migration
  def up
    create_table :dispositivofisicos do |tabla|
      tabla.string :nome
      tabla.string :descricion
      tabla.string :situacion
      tabla.string :url
      tabla.column :dispositivoloxico_id, :integer
      tabla.column :listareproducion_id, :integer
    end
  end

  def down
    drop_table :dispositivofisicos
  end
end
