class CreaTablaDiapositivasListareproducions < ActiveRecord::Migration
  def up
    create_table 'diapositivas_listareproducions' do |tabla|
      tabla.column :diapositiva_id, :integer
      tabla.column :listareproducion_id, :integer
      tabla.float :factorTempo
      tabla.integer :orde
    end
  end

  def down
    drop_table 'diapositivas_listareproducions'
  end
end
