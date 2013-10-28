class CamposFormatosSubformato < ActiveRecord::Base
  attr_accessible :campos_formatos_formato_id, :campos_formatos_campo_id, :subformato_id, :posicionX, :posicionY, :lonxitudeX, :lonxitudeY, :campos_formato_id
  belongs_to :subformato
  belongs_to :campos_formato
end
