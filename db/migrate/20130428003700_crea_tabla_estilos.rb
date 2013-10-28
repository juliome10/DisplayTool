class CreaTablaEstilos < ActiveRecord::Migration
  def up
    create_table :estilos do |tabla|
      tabla.string :nome
      tabla.string :descricion
      tabla.string :background_color
      tabla.string :background_image
      tabla.string :background_repeat
      tabla.string :background_position
      tabla.string :background_position_x
      tabla.string :background_position_y
      tabla.string :background_size
      tabla.string :background_size_x
      tabla.string :background_size_y
      tabla.string :background_size_val
    end
  end
  def down
    drop_table :estilos
  end
end
