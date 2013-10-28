class CreaTablaDispositivoloxicos < ActiveRecord::Migration
  def up
    create_table :dispositivoloxicos do |tabla|
      tabla.integer :relacionAspectoHorizontal
      tabla.integer :relacionAspectoVertical
    end
  end

  def down
    drop_table :dispositivoloxicos
  end
end
