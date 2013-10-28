class Campo < ActiveRecord::Base
  attr_accessible :id, :tipo, :subtipo
  has_many :campos_formatos, :dependent => :delete_all
  has_many :formatos, :through => :campos_formatos
  has_many :campos_estilos, :dependent => :delete_all
  has_many :estilos, :through => :campos_estilos
end
