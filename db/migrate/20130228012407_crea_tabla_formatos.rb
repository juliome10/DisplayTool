class CreaTablaFormatos < ActiveRecord::Migration
  def up
    create_table :formatos do |tabla|
      tabla.string :nome, :limit => 20
      tabla.string :descricion, :limit => 100
    end
  end

  def down
    drop_table :formatos
  end
end
