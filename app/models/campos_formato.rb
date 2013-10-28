class CamposFormato < ActiveRecord::Base
  attr_accessible :campo_id, :formato_id, :id
  belongs_to :formato
  belongs_to :campo
  has_many :campos_formatos_subformatos
  has_many :subformatos, :through => :campos_formatos_subformatos
end
