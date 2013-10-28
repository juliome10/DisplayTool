class Formato < ActiveRecord::Base
   attr_accessible :id, :nome, :descricion
   has_many :subformatos, :dependent => :delete_all
   has_many :campos_formatos, :dependent => :delete_all
   has_many :campos, :through => :campos_formatos
end
