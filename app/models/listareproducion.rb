class Listareproducion < ActiveRecord::Base
   attr_accessible :id, :factorTempo, :urlComezo, :nome
   has_many :diapositivas_listareproducions
   has_many :diapositivas, :through => :diapositivas_listareproducions
   has_many :dispositivoloxicos
end
