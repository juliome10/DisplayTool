class Dispositivoloxico < ActiveRecord::Base
   attr_accessible :id, :relacionAspectoHorizontal, :relacionAspectoVertical
   has_many :subformatos, :dependent => :delete_all
   has_many :dispositivofisicos
end
