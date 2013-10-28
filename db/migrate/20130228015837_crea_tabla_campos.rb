class CreaTablaCampos < ActiveRecord::Migration
  def up
    create_table :campos do |tabla|
      tabla.string :tipo, :limit => 30
      tabla.string :subtipo, :limit => 30
    end
  end

  def down
    drop_table :campos
  end
end
