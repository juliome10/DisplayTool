# encoding: utf-8
class DiapositivasController < ApplicationController
  # GET /diapositivas
  # GET /diapositivas.json
  def index
    #Cada diapositiva
    @diapositivas = Diapositiva.all
    #Almacenamento dos dispositivos
    @diapositivas_dispositivo = Array.new
    #Almacenamento dos formatos das diapositivas
    @diapositivas_formato = Array.new
    #Recóllese a información de cada diapositiva
    @diapositivas.each do |diapositiva|
      #Dispositivo para o que está deseñado. Acceso por diapositiva -> Subformato -> Dispositivo
      @diapositiva_subformato = diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
      @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
      @diapositivas_dispositivo << @dispositivo.relacionAspectoHorizontal.to_s + ":" + @dispositivo.relacionAspectoVertical.to_s
      #Formato da diapositiva
      @diapositivas_formato << Formato.find(diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    end
  end

  # GET /diapositivas/1
  # GET /diapositivas/1.json
  def show
    @diapositiva = Diapositiva.find(params[:id])
    @diapositiva_formato = Formato.find(@diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
    @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
    @diapositiva_dispositivo = @dispositivo.relacionAspectoHorizontal.to_s + ":" + @dispositivo.relacionAspectoVertical.to_s

    #Campos da diapositiva
    @diapositiva_campos = Array.new
    @diapositiva.campos_formatos_subformatos_diapositivas.each do |rexistro|
      @diapositiva_campos << Campo.find(rexistro.campos_formatos_subformatos_campos_formatos_campo_id)
    end
  end

  # GET /diapositivas/new
  # GET /diapositivas/new.json
  def new
    @diapositiva = Diapositiva.new
    @formatos = Formato.all
    @subformatos = Subformato.all
    @dispositivosloxicos = Dispositivoloxico.all
    #Si xa escollemos un formato, búscase para recoller os seus datos
    if params[:idFormato]
      @estilos = Estilo.all
      @formato = Formato.find(params[:idFormato])
      #Rexistros dos campos que contén
      @rexistros = CamposFormato.find_all_by_formato_id(@formato.id)
      #Datos que serán impresos
      @imprimirDispositivos = ""
      @imprimirSubformatos = ""
      @subformatosEscollidos = params[:subformato]
      @formato.subformatos.each_with_index do |subformato,i|
        @subformatosEscollidos.each do |subformatoEscollido|
          if subformato.id == subformatoEscollido.to_i
            @imprimirDispositivos = @imprimirDispositivos + subformato.dispositivoloxico.relacionAspectoHorizontal.to_s + ":" + subformato.dispositivoloxico.relacionAspectoVertical.to_s + " "
            @imprimirSubformatos = @imprimirSubformatos + subformato.id.to_s + " "
          end
        end
      end
    end

    #Imaxes en directorio
    @imaxes = Dir.glob("app/assets/images/usuario/*")
    #Vídeos en directorio
    @videos = Dir.glob("public/videos/*")

  end

  # GET /diapositivas/1/edit
  def edit
    @diapositiva = Diapositiva.find(params[:id])
    @diapositiva_formato = Formato.find(@diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
    @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
    @diapositiva_dispositivo = @dispositivo.relacionAspectoHorizontal.to_s + ":" + @dispositivo.relacionAspectoVertical.to_s

    #Campos da diapositiva
    @diapositiva_campos = Array.new
    @diapositiva.campos_formatos_subformatos_diapositivas.each do |registro|
      @diapositiva_campos << Campo.find(registro.campos_formatos_subformatos_campos_formatos_campo_id)
    end

    #Rexistros dos campos que contén
    @rexistrosCamposFormato = CamposFormato.find_all_by_formato_id(@diapositiva_formato)
    
    #Estilos existentes
    @estilos = Estilo.all
    #Imaxes en directorio
    @imaxes = Dir.glob("app/assets/images/usuario/*")
    #Vídeos en directorio
    @videos = Dir.glob("public/videos/*")

  end

  # POST /diapositivas
  # POST /diapositivas.json
  def create
    #Configuración do ficheiro
    @path = "public/contidos/"
    @extension = ".html"

    #Mensaxe para imprimir
    @diapositivasCreadas = Array.new

    #Recóllense os ids dos subformatos escollidos
    @subformatos = params[:subformatos]
    #Conocemos polo tanto, o formato
    @formato = Subformato.find(@subformatos[0]).formato.id
    #Recóllense os ids dos rexistros
    @idsRexistros = params[:idRexistro]
    #Recóllense os valores dos campos
    @valores = params[:valor]
    #Recóllese o estilo
    @idEstilo = params[:estilo]
    #Búsqueda do estilo
    @estilo = Estilo.find(@idEstilo[0])
    

    @subformatos.each do |subformato|
      #Para cada subformato, crease unha diapositiva
      @diapositiva = Diapositiva.create(:nome => params[:nome])
      #Asignación do estilo
      @diapositiva.update_attributes!(:estilo_id => @estilo.id)
      #Creouse unha diapositiva, polo tanto almaceno o seu id, para logo informar
      @diapositivasCreadas << @diapositiva.id
      #O nome da diapositiva será o id xerado
      @nombre = @diapositiva.id.to_s
      #Configúrase o nome do ficheiro HTML a crear
      @nombreFichero = @path + @nombre + @extension
      outFile = File.new(@nombreFichero, "w")

      #AQUÍ VAI A PLANTILLA HTML
      plantilla()
      outFile.puts(@plantilla)

      #Plantillas para o estilo, o contido html e o javascript
      @style = "<style type=\"text/css\">\n\t"
      @script = "<script type=\"text/javascript\">\n\t"
      @html = ""

      #Créase o css para o fondo, segundo as propiedades escollidas
      @style = @style + "body{\n"

      #Cor de fondo
      if !@estilo.background_color.nil? && @estilo.background_color.length > 0
        @style = @style + "\t\tbackground-color: " + @estilo.background_color + ";\n"
      end

      #Imaxe
      if !@estilo.background_image.nil? && @estilo.background_image.length > 0
        @style = @style + "\t\tbackground-image: url(\"" + @estilo.background_image + "\");\n"
        #Imaxe > Repetición
        if !@estilo.background_repeat.nil? && @estilo.background_repeat.length > 0
          case @estilo.background_repeat
            when 'Repetir X e Y'
              @background_repeat_css = "repeat"
            when 'Repetir X'
              @background_repeat_css = "repeat-x"
            when 'Repetir Y'
              @background_repeat_css = "repeat-y"
            when 'Non repetir'
              @background_repeat_css = 'no-repeat'
          end
          @style = @style + "\t\tbackground-repeat: " + @background_repeat_css + ";\n"
        end
        #Imaxe > Posición
        if !@estilo.background_position.nil? && @estilo.background_position.length > 0
          case @estilo.background_position
            when 'Esquerda Arriba'
              @background_position_css = "left top"
            when 'Esquerda Centro'
              @background_position_css = "left center"
            when 'Esquerda Abaixo'
              @background_position_css = "left bottom"
            when 'Dereita Arriba'
              @background_position_css = "right top"
            when 'Dereita Centro'
              @background_position_css = "right center"
            when 'Dereita Abaixo'
              @background_position_css = "right bottom"
            when 'Centro Arriba'
              @background_position_css = "center top"
            when 'Centro Centro'
              @background_position_css = "center center"
            when 'Centro Abaixo'
              @background_position_css = "center bottom"
            when 'Posicion X Posicion Y'
              @background_position_css = @estilo.background_position_x + "px " + @estilo.background_position_y + "px"
            when '%x %y'
              @background_position_css = @estilo.background_position_x + "% " + @estilo.background_position_y + "%"
          end
          @style = @style + "\t\tbackground-position: " + @background_position_css + ";\n"
        end
        #Imaxe > Tamaño
        if !@estilo.background_size.nil? && @estilo.background_size.length > 0
          case @estilo.background_size
          when 'Cover'
            @background_size_css = "cover"
          when 'Contain'
            @background_size_css = "contain"
          when 'X pixels Y pixels'
            @background_size_css = @estilo.background_size_x + "px " + @estilo.background_size_y + "px"
          when 'Pixels'
            @background_size_css = @estilo.background_size_val + "px"
          when '%x %y'
            @background_size_css = @estilo.background_size_x + "% " + @estilo.background_size_y + "%"
          when 'Porcentaxe'
            @background_size_css = @estilo.background_size_val + "%"
          end
          @style = @style + "\t\tbackground-size: " + @background_size_css + ";\n"
        end
      end
      @style = @style + "\t}\n\n"
      
      #Recórrense os campos e os seus valores
      @idsRexistros.zip @valores
      @idsRexistros.zip(@valores).each do |idRexistro,valor|
        #Búscase a entrada de campos_formatos_subformatos
        @datosCampo = CamposFormatosSubformato.find_by_campos_formato_id_and_subformato_id(idRexistro,subformato)
        #Búsqueda da información do campo
        @campo = Campo.find(@datosCampo.campos_formatos_campo_id)
        #Crease unha entrada para cada campo - formato - subformato - diapositiva
        CamposFormatosSubformatosDiapositiva.create(:campos_formatos_subformatos_campos_formatos_formato_id => @formato, :campos_formatos_subformatos_campos_formatos_campo_id => @campo.id, :campos_formatos_subformatos_subformato_id => subformato, :diapositiva_id => @diapositiva.id, :contido => valor, :campos_formatos_subformato_id => @datosCampo.id)
        
        #Si o campo é unha imaxe, imprimirase a etiqueta imaxe
        if @campo.tipo == 'Imaxe'
          #Xeración do estilo
          @style = @style + "\tdiv#imaxe" + @datosCampo.id.to_s + "{\n\t\t" +
              "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
              "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t\t" +
              "background-image: url(\"" + valor + "\");\n\t\t" +
              "position: absolute;\n\t\t" +
              "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
              "top: " + @datosCampo.posicionY.to_s + "%;\n\t" +
              "}\n\n"

          #Xeración da imaxe
          @html = @html + "<div id=\"imaxe" + @datosCampo.id.to_s + "\"></div>\n\n"

          #Escalado
          @script = @script + "var img = document.getElementById(\"imaxe" + @datosCampo.id.to_s + "\");\n" +
                              "var fondo = new Image;\n" +
                              "var ruta = $(\"#imaxe" + @datosCampo.id.to_s + "\").css('background-image');\n" +
                              "ruta2 = ruta.substring(5,ruta.length-2);\n" +
                              "fondo.src = ruta2;\n\n" +

                              "var bgImgWidth = fondo.width;\n" +
                              "var bgImgHeight = fondo.height;\n\n" +

                              "if (fondo.width > fondo.height){\n\t" +
                                  "m = fondo.width;\n\t" +
                                  "n = fondo.height;\n\t" +
                                  "mprima = img.clientWidth;\n\t" +
                                  "nprima = img.clientHeight;\n" +
                              "}else{\n\t" +
                                  "m = fondo.height;\n\t" +
                                  "n = fondo.width;\n\t" +
                                  "mprima = img.clientHeight;\n\t" +
                                  "nprima = img.clientWidth;\n" +
                              "}\n\n" +

                              "li = nprima / n;\n" +
                              "ls = mprima / m;\n\n" +

                              "F = li + (" + Parametro.find_by_variable("escalado_imaxe").valor.to_s + "*(ls-li)/100);\n\n" +

                              "Fm = F * m;\n" +
                              "Fn = F * n;\n" +
                              "tamano = Fm + \"px, \" + Fn + \"px;\"\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-size\",tamano);\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-position\",\"center\");\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-repeat\",\"no-repeat\");\n"
                            
        elsif @campo.tipo == 'Vídeo'
          if @campo.subtipo == 'Local'
            #Xeración do estilo
            @style = @style + "\tvideo#video{\n\t\t" +
              "position: absolute;\n\t\t" +
              "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
              "top: " + @datosCampo.posicionY.to_s + "%;\n\t" +
              "}\n"

            #Xeración do html
            @html = @html + "<video id=\"video\" width=\"" + @datosCampo.lonxitudeX.to_s + "%\" height=\"" + @datosCampo.lonxitudeY.to_s + "%\" autoplay>" +
                     "<source src=\"" + valor + "\" type=\"video/ogg\">" +
                     "Your browser does not support the video tag." +
                     "</video>\n\n"

          elsif @campo.subtipo == 'Embebido'
            #Xeración do estilo
            @style = @style + "\tiframe{\n\t\t" +
              "position: absolute;\n\t\t" +
              "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
              "top: " + @datosCampo.posicionY.to_s + "%;\n\t\t" +
              "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
              "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t" +
              "}\n\n"

              #Script para engadir o autoplay ó vídeo
              @script = @script + "video = document.getElementsByTagName(\'iframe\')[0];\n\t" +
                                  "video.src = video.src + \"?autoplay=1\"\n"
              
            #Xeración do html
            @html = @html + valor + "\n\n"

          end
        else
          #Búsqueda da características do estilo
          @rexistro = CamposEstilo.find_by_estilo_id_and_campo_id(@estilo.id,@campo.id)
          #Tradución dos aliñados en propiedades css
          case @rexistro.alinadoHorizontal
            when 'Esquerda'
              @horizontal = 'left'
            when 'Dereita'
              @horizontal = 'right'
            when 'Centrado'
              @horizontal = 'center'
            when 'Xustificado'
              @horizontal = 'justify'
            else
              @horizontal = ""
          end
          case @rexistro.alinadoVertical
            when 'Arriba'
              @vertical = 'top'
            when 'Abaixo'
              @vertical = 'bottom'
            when 'Centro'
              @vertical = 'middle'
            else
              @vertical = ""
          end

          #Definición do estilo
          @style = @style + "\tdiv#campo" + @datosCampo.id.to_s + "{\n\t\t" +
                  "font-family: \"" + @rexistro.fonte + "\";\n\t\t" +
                  "font-size: " + @rexistro.tamano + ";\n\t\t" +
                  "color: " + @rexistro.cor + ";\n\t\t" +
                  "text-align: " + @horizontal + ";\n\t\t" +
                  "position: absolute;\n\t\t" +
                  "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
                  "top: " + @datosCampo.posicionY.to_s + "%;\n\t\t" +
                  "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
                  "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t" +
                  "}\n\n"

          #Xeración do html
          @html = @html + "<div id=\"campo" + @datosCampo.id.to_s + "\" style=\"display:table\"> \n\t" +
                          "<div style=\"display:table-cell; vertical-align:" + @vertical + "\"> \n\t\t" +
                          valor + "\n\t" +
                          "</div>\n" +
                          "</div>\n\n"

        end
      end
      
      #Péchanse a plantilla de estilo e script
      @style = @style + "</style>\n\n"
      @script = @script + "</script>\n"
      
      #Imprímense no .html
      outFile.puts(@style)
      outFile.puts(@html)
      outFile.puts(@script)

      #Péchase o ficheiro
      outFile.close

      #Actualízase a URL da diapositiva
      @diapositiva.update_attributes!(:url => @nombreFichero)
    end

    #Creación da mensaxe de información
    @imprimir = ""
    if @diapositivasCreadas.length == 1
      flash[:notificacion] = "Diapositiva creada con éxito."
    else
      flash[:notificacion] = "Diapositivas creadas con éxito."
    end
    redirect_to :controller => "diapositivas", :action => "index"
  end

  # PUT /diapositivas/1
  # PUT /diapositivas/1.json
  def update
    #Diapositiva a actualizar
    @diapositiva = Diapositiva.find(params[:id])

    #Si soamente se queren actualizar os datos
    if params[:accion] == 'datos'
      @diapositiva.update_attributes!(:nome => params[:nome])
    else
      #Subformato da diapositiva
      @subformato = CamposFormatosSubformatosDiapositiva.find_by_diapositiva_id(@diapositiva.id).campos_formatos_subformatos_subformato_id
      #Recollemos os ids dos campos
      @idsRexistros = params[:idRexistro]
      #Recollemos os valores dos campos
      @valores = params[:valor]

      #Recóllese o estilo
      @idEstilo = params[:estilo]
      #Búsqueda do estilo
      @estilo = Estilo.find(@idEstilo[0])
      #Actualización do estilo da diapositiva
      @diapositiva.update_attributes!(:estilo_id => @estilo.id)
      #Configuración do ficheiro
      @path = "public/contidos/"
      @extension = ".html"
      #O nome da diapositiva será o id xerado
      @nombre = @diapositiva.id.to_s
      #Configúrase o nome do ficheiro HTML a crear
      @nombreFichero = @path + @nombre + @extension
      #Elimínase o ficheiro .html para volver a crealo.
      File.delete(@nombreFichero)
      outFile = File.new(@nombreFichero, "w")

      #AQUÍ VAI A PLANTILLA HTML
      plantilla()
      outFile.puts(@plantilla)

      #Plantillas para o estilo, o contido html e o javascript
      @style = "<style type=\"text/css\">\n\t"
      @script = "<script type=\"text/javascript\">\n\t"
      @html = ""

      #Créase o css para o fondo, segundo as propiedades escollidas
        @style = @style + "body{\n"

        #Cor de fondo
        if !@estilo.background_color.nil? && @estilo.background_color.length > 0
          @style = @style + "\t\tbackground-color: " + @estilo.background_color + ";\n"
        end

        #Imaxe
        if !@estilo.background_image.nil? && @estilo.background_image.length > 0
          @style = @style + "\t\tbackground-image: url(\"" + @estilo.background_image + "\");\n"
          #Imaxe > Repetición
          if !@estilo.background_repeat.nil? && @estilo.background_repeat.length > 0
            case @estilo.background_repeat
              when 'Repetir X e Y'
                @background_repeat_css = "repeat"
              when 'Repetir X'
                @background_repeat_css = "repeat-x"
              when 'Repetir Y'
                @background_repeat_css = "repeat-y"
              when 'Non repetir'
                @background_repeat_css = 'no-repeat'
            end
            @style = @style + "\t\tbackground-repeat: " + @background_repeat_css + ";\n"
          end
          #Imaxe > Posición
          if !@estilo.background_position.nil? && @estilo.background_position.length > 0
            case @estilo.background_position
              when 'Esquerda Arriba'
                @background_position_css = "left top"
              when 'Esquerda Centro'
                @background_position_css = "left center"
              when 'Esquerda Abaixo'
                @background_position_css = "left bottom"
              when 'Dereita Arriba'
                @background_position_css = "right top"
              when 'Dereita Centro'
                @background_position_css = "right center"
              when 'Dereita Abaixo'
                @background_position_css = "right bottom"
              when 'Centro Arriba'
                @background_position_css = "center top"
              when 'Centro Centro'
                @background_position_css = "center center"
              when 'Centro Abaixo'
                @background_position_css = "center bottom"
              when 'Posicion X Posicion Y'
                @background_position_css = @estilo.background_position_x + "px " + @estilo.background_position_y + "px"
              when '%x %y'
                @background_position_css = @estilo.background_position_x + "% " + @estilo.background_position_y + "%"
            end
            @style = @style + "\t\tbackground-position: " + @background_position_css + ";\n"
          end
          #Imaxe > Tamaño
          if !@estilo.background_size.nil? && @estilo.background_size.length > 0
            case @estilo.background_size
            when 'Cover'
              @background_size_css = "cover"
            when 'Contain'
              @background_size_css = "contain"
            when 'X pixels Y pixels'
              @background_size_css = @estilo.background_size_x + "px " + @estilo.background_size_y + "px"
            when 'Pixels'
              @background_size_css = @estilo.background_size_val + "px"
            when '%x %y'
              @background_size_css = @estilo.background_size_x + "% " + @estilo.background_size_y + "%"
            when 'Porcentaxe'
              @background_size_css = @estilo.background_size_val + "%"
            end
            @style = @style + "\t\tbackground-size: " + @background_size_css + ";\n"
          end
        end
        @style = @style + "\t}\n\n"

      #Recórrense os campos e os seus valores
        @idsRexistros.zip @valores
        @idsRexistros.zip(@valores).each do |idRexistro,valor|
        #Búscase a entrada de campos_formatos_subformatos
        @datosCampo = CamposFormatosSubformato.find_by_campos_formato_id_and_subformato_id(idRexistro,@subformato)
        #Búsqueda da información do campo
        @campo = Campo.find(@datosCampo.campos_formatos_campo_id)

        #Modificar os rexistros da táboa relación campos_formatos_subformatos_dipositivas
          @rexistro = CamposFormatosSubformatosDiapositiva.find_by_diapositiva_id_and_campos_formatos_subformato_id(@diapositiva.id, @datosCampo.id)
          @rexistro.update_attributes!(:contido => valor)
          #Formato da diapositiva
          @formato = Formato.find(@rexistro.campos_formatos_subformatos_campos_formatos_formato_id)

          #Si o campo é unha imaxe, imprimirase a etiqueta imaxe
          if @campo.tipo == 'Imaxe'
            #Xeración do estilo
            @style = @style + "\tdiv#imaxe" + @datosCampo.id.to_s + "{\n\t\t" +
                "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
                "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t\t" +
                "background-image: url(\"" + valor + "\");\n\t\t" +
                "position: absolute;\n\t\t" +
                "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
                "top: " + @datosCampo.posicionY.to_s + "%;\n\t" +
                "}\n\n"

            #Xeración da imaxe
            @html = @html + "<div id=\"imaxe" + @datosCampo.id.to_s + "\"></div>\n\n"

          #Escalado
          @script = @script + "var img = document.getElementById(\"imaxe" + @datosCampo.id.to_s + "\");\n" +
                              "var fondo = new Image;\n" +
                              "var ruta = $(\"#imaxe" + @datosCampo.id.to_s + "\").css('background-image');\n" +
                              "ruta2 = ruta.substring(5,ruta.length-2);\n" +
                              "fondo.src = ruta2;\n\n" +

                              "var bgImgWidth = fondo.width;\n" +
                              "var bgImgHeight = fondo.height;\n\n" +

                              "if (fondo.width > fondo.height){\n\t" +
                                  "m = fondo.width;\n\t" +
                                  "n = fondo.height;\n\t" +
                                  "mprima = img.clientWidth;\n\t" +
                                  "nprima = img.clientHeight;\n" +
                              "}else{\n\t" +
                                  "m = fondo.height;\n\t" +
                                  "n = fondo.width;\n\t" +
                                  "mprima = img.clientHeight;\n\t" +
                                  "nprima = img.clientWidth;\n" +
                              "}\n\n" +

                              "li = nprima / n;\n" +
                              "ls = mprima / m;\n\n" +

                              "F = li + (" + Parametro.find_by_variable("escalado_imaxe").valor.to_s + "*(ls-li)/100);\n\n" +

                              "Fm = F * m;\n" +
                              "Fn = F * n;\n" +
                              "tamano = Fm + \"px, \" + Fn + \"px;\"\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-size\",tamano);\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-position\",\"center\");\n" +
                              "$(\"#imaxe" + @datosCampo.id.to_s + "\").css(\"background-repeat\",\"no-repeat\");\n"

          elsif @campo.tipo == 'Vídeo'
            if @campo.subtipo == 'Local'
              #Xeración do estilo
              @style = @style + "\tvideo#video{\n\t\t" +
                "position: absolute;\n\t\t" +
                "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
                "top: " + @datosCampo.posicionY.to_s + "%;\n\t" +
                "}\n"

              #Xeración do html
              @html = @html + "<video id=\"video\" width=\"" + @datosCampo.lonxitudeX.to_s + "%\" height=\"" + @datosCampo.lonxitudeY.to_s + "%\" autoplay>" +
                       "<source src=\"" + valor + "\" type=\"video/ogg\">" +
                       "Your browser does not support the video tag." +
                       "</video>\n\n"

            elsif @campo.subtipo == 'Embebido'
              #Xeración do estilo
              @style = @style + "\tiframe{\n\t\t" +
                "position: absolute;\n\t\t" +
                "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
                "top: " + @datosCampo.posicionY.to_s + "%;\n\t\t" +
                "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
                "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t" +
                "}\n\n"

              #Script para engadir o autoplay ó vídeo
              @script = @script + "video = document.getElementsByTagName(\'iframe\')[0];\n\t" +
                                  "video.src = video.src + \"?autoplay=1\"\n"
              #Xeración do html
              @html = @html + valor + "\n\n"
              
            end
          else
            #Búsqueda da características do estilo
            @rexistro = CamposEstilo.find_by_estilo_id_and_campo_id(@estilo.id,@campo.id)

            #Tradución dos aliñados en propiedades css
              case @rexistro.alinadoHorizontal
                when 'Esquerda'
                  @horizontal = 'left'
                when 'Dereita'
                  @horizontal = 'right'
                when 'Centrado'
                  @horizontal = 'center'
                when 'Xustificado'
                  @horizontal = 'justify'
              end
              case @rexistro.alinadoVertical
                when 'Arriba'
                  @vertical = 'top'
                when 'Abaixo'
                  @vertical = 'bottom'
                when 'Centro'
                  @vertical = 'middle'
              end
            #Definición do estilo
            @style = @style + "\tdiv#campo" + @datosCampo.id.to_s + "{\n\t\t" +
                    "font-family: \"" + @rexistro.fonte + "\";\n\t\t" +
                    "font-size: " + @rexistro.tamano + ";\n\t\t" +
                    "color: " + @rexistro.cor + ";\n\t\t" +
                    "text-align: " + @horizontal + ";\n\t\t" +
                    "position: absolute;\n\t\t" +
                    "left: " + @datosCampo.posicionX.to_s + "%;\n\t\t" +
                    "top: " + @datosCampo.posicionY.to_s + "%;\n\t\t" +
                    "width: " + @datosCampo.lonxitudeX.to_s + "%;\n\t\t" +
                    "height: " + @datosCampo.lonxitudeY.to_s + "%;\n\t" +
                    "}\n\n"

           #Xeración do html
            @html = @html + "<div id=\"campo" + @datosCampo.id.to_s + "\" style=\"display:table\"> \n\t" +
                            "<div style=\"display:table-cell; vertical-align:" + @vertical + "\"> \n\t\t" +
                            valor + "\n\t" +
                            "</div>\n" +
                            "</div>\n\n"

          end
        end

        #Péchanse as plantillas
        @style = @style + "</style>\n\n"
        @script = @script + "</script>"

        #Imprímense no .html
        outFile.puts(@style)
        outFile.puts(@html)
        outFile.puts(@script)

        #Péchase o ficheiro
        outFile.close
    end

    #Mensaxe informativo
    flash[:notificacion] = "Diapositiva actualizada con éxito."
    redirect_to diapositivas_path
  end

  
  def destroy
    #Identifícase a diapositiva
    @diapositiva = Diapositiva.find(params[:id])

    #Elimínanse todos os seus contidos da táboa da relación
    @contidos = @diapositiva.campos_formatos_subformatos_diapositivas
    @contidos.each do |contido|
      contido.destroy
    end

    #Elimínase o ficheiro .html
    #Configuración do ficheiro
    @path = "public/contidos/"
    @extension = ".html"
    @nombre = @diapositiva.id.to_s
    @nombreFichero = @path + @nombre + @extension
    #File.delete(@nombreFichero)
    
    #Elimínase a diapositiva
    @diapositiva.destroy

    flash[:notificacion] = "Diapositiva eliminada con éxito"
    redirect_to diapositivas_path
  end

  def plantilla
    @plantilla = "<!DOCTYPE html>\n" +
                 "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                 "<script src=\"/assets/jquery.js?body=1\" type=\"text/javascript\"></script>"
  end

  def estilo
    @estilo = "<style type=\"text/css\">" +
              "div#proba{" +
              "height: 50%;" +
              "width: 50%;" +
              "}"
              "</style>"
  end
end
