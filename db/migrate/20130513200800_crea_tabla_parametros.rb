class CreaTablaParametros < ActiveRecord::Migration
  def up
    create_table :parametros do |tabla|
      tabla.string :nome
      tabla.string :variable
      tabla.string :valor
      tabla.string :descricion
    end
  end

  def down
    drop_table :parametros
  end
end
