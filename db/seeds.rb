# encoding: UTF-8

#CONFIGURACIÓN

#Dispositivos lóxicos
Dispositivoloxico.create(:relacionAspectoHorizontal => "4", :relacionAspectoVertical => "3")
Dispositivoloxico.create(:relacionAspectoHorizontal => "3", :relacionAspectoVertical => "4")
Dispositivoloxico.create(:relacionAspectoHorizontal => "16", :relacionAspectoVertical => "9")

#Campos
Campo.create(:tipo => "Texto", :subtipo => "Título")
Campo.create(:tipo => "Texto", :subtipo => "Subtítulo")
Campo.create(:tipo => "Texto", :subtipo => "Resumo")
Campo.create(:tipo => "Texto", :subtipo => "Descrición")
Campo.create(:tipo => "Texto", :subtipo => "Pé")
Campo.create(:tipo => "Imaxe", :subtipo => "Logo")
Campo.create(:tipo => "Imaxe", :subtipo => "Foto")
Campo.create(:tipo => "Vídeo", :subtipo => "Local")
Campo.create(:tipo => "Vídeo", :subtipo => "Embebido")

#Parámetros de configuración
Parametro.create(:nome => 'Aliñado horizontal da descrición', :variable => 'descricion_alinadoHorizontal', :valor => 'Esquerda')
Parametro.create(:nome => 'Aliñado vertical da descrición', :variable => 'descricion_alinadoVertical', :valor =>	'Arriba')
Parametro.create(:nome => 'Cor da fonte da descrición', :variable => 'descricion_cor', :valor => '#ffffff')
Parametro.create(:nome => 'Tamaño da fonte da descrición', :variable => 'descricion_tamano', :valor => '18px')
Parametro.create(:nome => 'Fonte da descrición', :variable => 'descricion_fonte', :valor => 'Comic Sans MS')
Parametro.create(:nome => 'Aliñado horizontal do pé', :variable => 'pe_alinadoHorizontal', :valor => 'Centrado')
Parametro.create(:nome => 'Aliñado vertical do pé', :variable => 'pe_alinadoVertical', :valor => 'Abaixo')
Parametro.create(:nome => 'Cor da fonte do pé', :variable => 'pe_cor', :valor => '#ffffff')
Parametro.create(:nome => 'Fonte do pé', :variable => 'pe_fonte', :valor => 'Comic Sans MS')
Parametro.create(:nome => 'Tamaño da fonte do pé', :variable => 'pe_tamano', :valor => '15px')
Parametro.create(:nome => 'Aliñado horizontal do resumo', :variable => 'resumo_alinadoHorizontal', :valor => 'Esquerda')
Parametro.create(:nome => 'Aliñado vertical do resumo', :variable => 'resumo_alinadoVertical', :valor => 'Arriba')
Parametro.create(:nome => 'Cor da fonte do resumo', :variable => 'resumo_cor', :valor => '#ffffff')
Parametro.create(:nome => 'Fonte do resumo', :variable => 'resumo_fonte', :valor => 'Comic Sans MS')
Parametro.create(:nome => 'Tamaño da fonte do resumo', :variable => 'resumo_tamano', :valor => '18px')
Parametro.create(:nome => 'Aliñado horizontal do subtítulo', :variable => 'subtitulo_alinadoHorizontal', :valor => 'Centrado')
Parametro.create(:nome => 'Aliñado vertical do subtítulo', :variable => 'subtitulo_alinadoVertical', :valor => 'Centro')
Parametro.create(:nome => 'Cor da fonte do subtítulo', :variable => 'subtitulo_cor', :valor => '#ffffff')
Parametro.create(:nome => 'Fonte do subtítulo', :variable => 'subtitulo_fonte', :valor => 'Comic Sans MS')
Parametro.create(:nome => 'Tamaño da fonte do subtítulo', :variable => 'subtitulo_tamano', :valor => '25px')
Parametro.create(:nome => 'Aliñado horizontal do título', :variable => 'titulo_alinadoHorizontal', :valor => 'Centrado')
Parametro.create(:nome => 'Aliñado vertical do título', :variable => 'titulo_alinadoVertical', :valor => 'Centro')
Parametro.create(:nome => 'Cor da fonte do título', :variable => 'titulo_cor', :valor => '#ffffff')
Parametro.create(:nome => 'Fonte do título', :variable => 'titulo_fonte', :valor => 'Comic Sans MS')
Parametro.create(:nome => 'Tamaño da fonte do título', :variable => 'titulo_tamano', :valor => '40px')
Parametro.create(:nome => 'Porcentaxe de escalado de imaxes', :variable => 'escalado_imaxe', :valor => '50', :descricion => 'Para que unha imaxe se adapte ás medidas dun campo, é necesario escalar as súas dimensións. Este parámetro define que valor se escollerá do intervalo que vai dende o mínimo dos dous factores de escalado ó máximo. Mídese en porcentaxe.')


 	