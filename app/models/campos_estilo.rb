class CamposEstilo < ActiveRecord::Base
  attr_accessible :cor, :tamano, :fonte, :alinadoHorizontal, :alinadoVertical, :campo_id, :estilo_id
  belongs_to :campo
  belongs_to :estilo
end
