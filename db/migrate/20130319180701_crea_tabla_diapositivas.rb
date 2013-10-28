class CreaTablaDiapositivas < ActiveRecord::Migration
  def up
    create_table :diapositivas do |tabla|
      tabla.string :nome
      tabla.string :url
      tabla.integer :estilo_id
    end
  end

  def down
    drop_table :diapositivas
  end
end
