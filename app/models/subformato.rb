class Subformato < ActiveRecord::Base
   attr_accessible :id, :formato_id, :dispositivoloxico_id
   belongs_to :formato
   belongs_to :dispositivoloxico
   has_many :campos_formatos_subformatos
   has_many :campos_formatos, :through => :campos_formatos_subformatos
end
