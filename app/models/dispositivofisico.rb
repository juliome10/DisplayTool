class Dispositivofisico < ActiveRecord::Base
   attr_accessible :nome, :descricion, :situacion, :dispositivoloxico_id, :listareproducion_id, :url
   belongs_to :dispositivoloxico
   belongs_to :listareproducion
end
