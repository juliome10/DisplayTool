class CreaTablaListareproducions < ActiveRecord::Migration
  def up
    create_table :listareproducions do |tabla|
      tabla.string :nome
      tabla.string :urlComezo
    end
  end

  def down
    drop_table :listareproducions
  end
end
