class CamposFormatosSubformatosDiapositiva < ActiveRecord::Base
  attr_accessible :campos_formatos_subformatos_campos_formatos_formato_id, :campos_formatos_subformatos_campos_formatos_campo_id, :campos_formatos_subformatos_subformato_id, :diapositiva_id, :contido, :campos_formatos_subformato_id
  belongs_to :diapositiva
  belongs_to :campos_formatos_subformato
end