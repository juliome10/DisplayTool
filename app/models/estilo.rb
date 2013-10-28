class Estilo < ActiveRecord::Base
   attr_accessible :id, :nome, :descricion, :background_color, :background_image, :background_repeat, :background_position, :background_position_x, :background_position_y, :background_size, :background_size_x, :background_size_y, :background_size_val
   has_many :campos_estilos
   has_many :campos, :through => :campos_estilos
   has_many :diapositivas
end
