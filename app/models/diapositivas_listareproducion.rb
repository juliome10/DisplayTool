class DiapositivasListareproducion < ActiveRecord::Base
  attr_accessible :diapositiva_id, :listareproducion_id, :factorTempo, :orde
  belongs_to :diapositiva
  belongs_to :listareproducion
 end
