class Diapositiva < ActiveRecord::Base
   attr_accessible :id, :url, :estilo_id, :nome
   belongs_to :estilo
   has_many :campos_formatos_subformatos_diapositivas
   has_many :campos_formatos_subformatos, :through => :campos_formatos_subformatos_diapositivas
   has_many :diapositivas_listareproducions
   has_many :listareproducions, :through => :diapositivas_listareproducions
end
