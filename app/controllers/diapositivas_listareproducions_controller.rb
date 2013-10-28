# encoding: utf-8

class DiapositivasListareproducionsController < ApplicationController
  def new
    @listareproducion = Listareproducion.find(params[:lista])
    @listareproducion_diapositivas = Array.new
    #Almacenamento dos formatos das diapositivas
    @listareproducion_formatos = Array.new
    @listareproducion_rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id)

    @listareproducion_rexistros.each do |rexistro|
      @listareproducion_diapositiva = Diapositiva.find(rexistro.diapositiva_id)
      @listareproducion_diapositivas << @listareproducion_diapositiva
      @listareproducion_formatos << Formato.find(@listareproducion_diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    end
    
    #Búsqueda do tipo de dispositivo para o que foi deseñada, se xa ten diapositivas
    if !@listareproducion_diapositivas.empty?
      @diapositiva = Diapositiva.find(@listareproducion_diapositivas[0])
      @diapositiva_formato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id
      @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
      @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico

      #Búsqueda de diapositivas que foron deseñadas para o dispositivo
      @subformatos = Subformato.find_all_by_dispositivoloxico_id(@dispositivo.id)
      #Extráense as entradas da táboa campos - formatos - subformatos - diapositivas que indiquen que as diapositivas son dos subformatos escollidos
      @diapositivas = Array.new
      #Extráense os formatos das diapositivas
      @diapositivas_formatos = Array.new
      #Gárdanse os ids das diapositivas para ser opcións do select na vista
      @opcionsSelect = Array.new
      @subformatos.each do |subformato|
        #Só se necesita o id da diapositiva, e con unha vez resulta suficiente
        @rexistros = CamposFormatosSubformatosDiapositiva.where(:campos_formatos_subformatos_subformato_id => subformato.id).select(:diapositiva_id).uniq
        @rexistros.each do |rexistro|
          #Recóllense os datos da diapositiva e introdúcese nun array
          @diapositiva = Diapositiva.find(rexistro.diapositiva_id)
          #Compróbase que a diapositiva non forme parte xa da lista de reprodución
          if !@listareproducion_diapositivas.include?(@diapositiva)
            @diapositivas << @diapositiva
            @formato = Formato.find(@diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
            @diapositivas_formatos << @formato
            @opcionsSelect << @diapositiva.id
          end
        end
      end
    #Senón, preséntanse todas as diapositivas creadas
    else
      #Todas as diapositivas
      @diapositivas = Diapositiva.all
      #Todos os dispositivos
      @dispositivos = Array.new
      #Opcións para presentar
      @opcionsSelect = Array.new
      #Para cada diapositiva, cóllese o seu dispositivo
      @diapositivas.each do |diapositiva|
        @diapositiva_subformato = diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
        @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
        @dispositivos << @dispositivo
        @opcionsSelect << diapositiva.id
      end
    end
  end

  def create
    #Datos recibidos
    @factorTempo = params[:factorTempoDiapositiva]
    @diapositiva_id = params[:diapositiva]
    @diapositiva = Diapositiva.find(@diapositiva_id)
    @listareproducion_id = params[:id]
    @listareproducion = Listareproducion.find(@listareproducion_id)
    
    #Recupérase a lista de repdrodución enteira (todos os rexistros de diapositivas - listareproducions)
    @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion_id)
    
    #Nova posición na lista
    @novaOrde = @rexistros.length + 1

    #Engádese a entrada na táboa da relación diapositivas - listareproducions
    DiapositivasListareproducion.create!(:diapositiva_id => @diapositiva_id, :listareproducion_id => @listareproducion_id, :factorTempo => @factorTempo, :orde => @novaOrde)

    #Copiar diapositiva á carpeta da lista
    FileUtils.cp "public/contidos/#{params[:diapositiva]}.html", "public/listas/#{@listareproducion.id}"


    #Correxir a diapositiva anterior e a actual, no caso de que existan máis de unha
    @numeroDiapositivas = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion_id)
    if @numeroDiapositivas.length > 1
      #Facer que a anterior apunte á actual e a actual á primeira
      @rexistroAnterior = DiapositivasListareproducion.find_by_listareproducion_id_and_orde(@listareproducion_id,@novaOrde-1)
      @rexistroActual = DiapositivasListareproducion.find_by_listareproducion_id_and_orde(@listareproducion_id,@novaOrde)
      @rexistroPrimeiro = DiapositivasListareproducion.find_by_listareproducion_id_and_orde(@listareproducion_id,1)
      @diapositivaAnterior = Diapositiva.find(@rexistroAnterior.diapositiva_id)
      @diapositivaPrimeira = Diapositiva.find(@rexistroPrimeiro.diapositiva_id)

      #Configuración do ficheiro
      @path = "public/listas/#{@listareproducion.id}/"
      @pathCompleto = "http://localhost:3000/public/listas/#{@listareproducion.id}/"
      @extension = ".html"

      #Nomes das diapositiva anterior, actual, e primeira
      @nomeAnterior = @diapositivaAnterior.id.to_s
      @nomeActual = @diapositiva.id.to_s
      @nomePrimeira = @diapositivaPrimeira.id.to_s

      #Paths das diapositivas anterior e actual
      @nomeFicheiroAnterior = @path + @nomeAnterior + @extension
      @nomeFicheiroActual = @path + @nomeActual + @extension
      @nomeFicheiroPrimeiro = @path + @nomePrimeira + @extension

      #Paths das diapositivas completo (Para imprimir na diapositiva estática)
      @direcionFicheiroAnterior = @pathCompleto + @nomeAnterior + @extension
      @direcionFicheiroActual = @pathCompleto + @nomeActual + @extension
      @direcionFicheiroPrimeiro = @pathCompleto + @nomePrimeira + @extension

      #O ficheiro anterior apuntará ó ficheiro actual, en lugar de apuntar ó primeiro (para facer o círculo antes).
      #Elimínase a última línea do ficheiro (etiqueta meta-tag refresh)
        #Cárganse as liñas
        linas = IO.readlines(@nomeFicheiroAnterior)
        #Elimínanse as últimas 9 liñas (script redirección)
        var = 1
        while var < 10
          linas.delete_at(linas.length-1)
          var += 1
        end
        #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
        File.open(@nomeFicheiroAnterior, 'w') do |f|
          linas.each{ |linea| f.puts(linea) }
        end
        #Contén vídeo a diapositiva?
        eVideo = false
        @diapositivaAnterior.campos_formatos_subformatos_diapositivas.each do |cfsd|
          @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
          if
            @campo.tipo == 'Vídeo'
            eVideo = true
            break
          end
        end

        #Ábrese o ficheiro para engadir o novo apuntamento
        File.open(@nomeFicheiroAnterior, 'a+') do |f|
          if eVideo == true
            f.puts("<script type=\"text/javascript\">\n\t" +
                        "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                          "window.location.replace(\"" + @direcionFicheiroActual + "\");\n\t" +
                        "});\n\n\t" +
                        "</script>\n\n\n\n")
          else
            f.puts("<script type=\"text/javascript\">\n\t" +
                        "function redirectLink() {\n\t\t" +
                          "window.location.replace(\"" + @direcionFicheiroActual + "\");\n\t" +
                        "}\n\n\t" +

                        "setTimeout(function () {\n\t\t" +
                          "redirectLink();\n\t" +
                        "}, " + @rexistroAnterior.factorTempo.to_i.to_s + "000);\n" +
                        "</script>")
          end
        end
      #O ficheiro actual apuntará ó primeiro rexistro
      outFile = File.open(@nomeFicheiroActual, "a+")
      #Contén vídeo a diapositiva?
        eVideo = false
        @diapositiva.campos_formatos_subformatos_diapositivas.each do |cfsd|
          @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
          if
            @campo.tipo == 'Vídeo'
            eVideo = true
            break
          end
        end
        if eVideo == true
            outFile.puts("<script type=\"text/javascript\">\n\t" +
                        "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                          "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                        "});\n\n\t" +
                        "</script>\n\n\n\n")
          else
            outFile.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, " + @rexistroActual.factorTempo.to_i.to_s + "000);\n" +
                      "</script>")
        end
      outFile.close
    else
      #Copiar diapositiva á carpeta da lista
      FileUtils.cp "public/contidos/#{params[:diapositiva]}.html", "public/listas/#{@listareproducion.id}"

      #A url de comezo será a dirección da primeira diapositiva da lista
      @listareproducion.update_attributes!(:urlComezo => "public/listas/#{@listareproducion.id}/#{params[:diapositiva]}.html")

      #Engádese a meta-tag refresh para logo ir cambiándoa con cada diapositiva nova.
      #Configuración do ficheiro
      @path = "public/listas/#{@listareproducion.id}/"
      @extension = ".html"

      #Nome da diapositiva
      @nome = params[:diapositiva]

      #Paths da diapositiva
      @nomeFicheiro = @path + @nome + @extension

      #Apertura de ficheiro para engadir etiqueta refresh, por agora sen apuntar a ningunha
      outFile = File.open(@nomeFicheiro, "a+")
      outFile.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace();\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, -1);\n" +
                      "</script>")
      outFile.close
    end
    flash[:notificacion] = "Lista de reprodución actualizada con éxito."
    redirect_to edit_listareproducion_path(@listareproducion)
  end

  def edit
    @rexistroActual = DiapositivasListareproducion.find(params[:id])
    @listareproducion = Listareproducion.find(@rexistroActual.listareproducion.id)
    @diapositiva = Diapositiva.find(@rexistroActual.diapositiva.id)
  end

  def update
    #Datos recibidos
    @rexistroActual = DiapositivasListareproducion.find(params[:id])
    #Recupérase a lista de reprodución á que pertence o rexistro
    @listareproducion = Listareproducion.find(@rexistroActual.listareproducion_id)

    #Intercambio de posicións
    #Se se trata de baixar un rexistro, necesítase o seguinte
    if params[:accion] == 'baixar'
      @rexistroSeguinte = DiapositivasListareproducion.find_by_listareproducion_id_and_orde(@listareproducion.id,@rexistroActual.orde+1)

      #Modificación das ordes do rexistro
      @ordeActual = @rexistroActual.orde
      @rexistroActual.update_attributes!(:orde => @rexistroSeguinte.orde)
      @rexistroSeguinte.update_attributes!(:orde => @ordeActual)

    #Se se trata de subir un rexistro, necesítase o anterior
    elsif params[:accion] == 'subir'
      @rexistroAnterior = DiapositivasListareproducion.find_by_listareproducion_id_and_orde(@listareproducion.id,@rexistroActual.orde-1)

      #Modificación das ordes do rexistro
      @ordeActual = @rexistroActual.orde
      @rexistroActual.update_attributes!(:orde => @rexistroAnterior.orde)
      @rexistroAnterior.update_attributes!(:orde => @ordeActual)

    #Se so se trata de modificar o factor temporal, actualízase o valor de dito atributo
    elsif params[:accion] == 'modificar'
      @rexistroActual.update_attributes!(:factorTempo => params[:factorTempo])
      #Actualízase na diapositiva
      #Configuración do ficheiro
      @path = "public/listas/#{@listareproducion.id}/"
      @extension = ".html"

      @nomeActual = @rexistroActual.diapositiva_id.to_s
      @nomeFicheiroActual = @path + @nomeActual + @extension
      @diapositivaActual = Diapositiva.find(@rexistroActual.diapositiva_id)

      #Cárganse as liñas
        linas = IO.readlines(@nomeFicheiroActual)
        #Elimínanse as últimas 9 liñas (script redirección)
        var = 1
        while var < 3
          linas.delete_at(linas.length-1)
          var += 1
        end
        #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
        File.open(@nomeFicheiroActual, 'w') do |f|
          linas.each{ |linea| f.puts(linea) }
        end
        #Ábrese o ficheiro para engadir o novo apuntamento
        File.open(@nomeFicheiroActual, 'a+') do |f|
        #Contén vídeo a diapositiva?
        eVideo = false
        @diapositivaActual.campos_formatos_subformatos_diapositivas.each do |cfsd|
          @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
          if @campo.tipo == 'Vídeo'
            eVideo = true
          break
          end
        end
          if eVideo == false
            f.puts("\t}, " + @rexistroActual.factorTempo.to_i.to_s + "000);\n" +
                    "</script>")
          end
        end
      end

    #No caso de que se variaran as ordes, actualizaranse
    if params[:accion] != 'modificar'
      #Configuración do ficheiro
      @path = "public/listas/#{@listareproducion.id}/"
      @pathCompleto = "http://localhost:3000/public/listas/#{@listareproducion.id}/"
      @extension = ".html"

      #Actualízanse os apuntamentos segundo a nova orde
      #Recupéranse todos os rexistros da lista de reprodución na súa orde
      @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
      @rexistros.each_with_index do |rexistro,i|
        #Para o último rexistro, apuntarase ó primeiro
        if rexistro.orde == @rexistros.length
          @nomeActual = rexistro.diapositiva_id.to_s
          @diapositivaActual = Diapositiva.find(rexistro.diapositiva_id)
          @nomePrimeiro = @rexistros[0].diapositiva_id.to_s
          @diapositivaPrimeira = Diapositiva.find(@rexistros[0].diapositiva_id)
          @nomeFicheiroActual = @path + @nomeActual + @extension
          @direcionFicheiroPrimeiro = @pathCompleto + @nomePrimeiro + @extension
          #Elimínase a última línea do ficheiro (etiqueta meta-tag refresh)
            #Cárganse as liñas
            linas = IO.readlines(@nomeFicheiroActual)
            #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
            #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
            File.open(@nomeFicheiroActual, 'w') do |f|
              linas.each{ |linea| f.puts(linea) }
            end
            #Ábrese o ficheiro para engadir o novo apuntamento
            File.open(@nomeFicheiroActual, 'a+') do |f|
              #Contén vídeo a diapositiva?
                eVideo = false
                @diapositivaActual.campos_formatos_subformatos_diapositivas.each do |cfsd|
                  @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
                  if @campo.tipo == 'Vídeo'
                    eVideo = true
                  break
                  end
                end

                if eVideo == true
                  f.puts("<script type=\"text/javascript\">\n\t" +
                          "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                          "});\n\n\t" +
                          "</script>\n\n\n\n")
                else
                  f.puts("<script type=\"text/javascript\">\n\t" +
                          "function redirectLink() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                          "}\n\n\t" +

                          "setTimeout(function () {\n\t\t" +
                            "redirectLink();\n\t" +
                          "}, " + rexistro.factorTempo.to_i.to_s + "000);\n" +
                          "</script>")
                end
            end
        #Senón, apuntarase ó seguinte
        else
          @nomeActual = rexistro.diapositiva_id.to_s
          @diapositivaActual = Diapositiva.find(rexistro.diapositiva_id)
          @nomeSeguinte = @rexistros[i+1].diapositiva_id.to_s
          @nomeFicheiroActual = @path + @nomeActual + @extension
          @direcionFicheiroSeguinte = @pathCompleto + @nomeSeguinte + @extension

           #Para o primeiro rexistro, actualízase a url de comezo da lista de reproducion
          if rexistro.orde == 1
            @listareproducion.update_attributes!(:urlComezo => "public/listas/#{@listareproducion.id}/#{@nomeActual}.html")
          end

          #Elimínase a última línea do ficheiro (etiqueta meta-tag refresh)
            #Cárganse as liñas
            linas = IO.readlines(@nomeFicheiroActual)
             #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
            #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
            File.open(@nomeFicheiroActual, 'w') do |f|
              linas.each{ |linea| f.puts(linea) }
            end
            #Ábrese o ficheiro para engadir o novo apuntamento
            File.open(@nomeFicheiroActual, 'a+') do |f|
              #Contén vídeo a diapositiva?
                eVideo = false
                @diapositivaActual.campos_formatos_subformatos_diapositivas.each do |cfsd|
                  @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
                  if @campo.tipo == 'Vídeo'
                    eVideo = true
                    break
                  end
                end

                if eVideo == true
                  f.puts("<script type=\"text/javascript\">\n\t" +
                          "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                          "});\n\n\t" +
                          "</script>\n\n\n\n")
                else
                  f.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, " + rexistro.factorTempo.to_i.to_s + "000);\n" +
                      "</script>")
                end
            end
        end
      end
    end
    flash[:notificacion] = "Lista de reprodución actualizada con éxito."
    redirect_to edit_listareproducion_path(@listareproducion)
  end

  def destroy
    #Datos recibidos
    @rexistroActual = DiapositivasListareproducion.find(params[:id])
    #Recupérase a lista de reprodución á que pertence o rexistro
    @listareproducion = Listareproducion.find(@rexistroActual.listareproducion_id)
    #Recupéranse todos os rexistros da lista de reprodución
    @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')

    #Configuración dos ficheiros
    @path = "public/listas/#{@listareproducion.id}/"
    @pathCompleto = "http://localhost:3000/public/listas/#{@listareproducion.id}/"
    @extension = ".html"

    #Diapositiva actual
    @diapositivaActual = Diapositiva.find(@rexistroActual.diapositiva_id)

    #Nome actual
    @nomeActual = @diapositivaActual.id.to_s

    #Path actual
    @nomeFicheiroActual = @path + @nomeActual + @extension

    #Path completo actual (para escribir no ficheiro)
    @direcionFicheiroActual = @pathCompleto + @nomeActual + @extension

    #1 A LISTA TEN POLO MENOS 3 DIAPOSITIVAS
    if @rexistros.length > 2
      #1.1 SI O REXISTRO É O PRIMEIRO
      if @rexistroActual.orde == 1
        #Datos necesarios: seguinte e última posicións
        @rexistroSeguinte = @rexistros[@rexistroActual.orde]
        @rexistroUltimo = @rexistros[@rexistros.length-1]
        @diapositivaSeguinte = Diapositiva.find(@rexistroSeguinte.diapositiva_id)
        @diapositivaUltima = Diapositiva.find(@rexistroUltimo.diapositiva_id)
        @nomeSeguinte = @diapositivaSeguinte.id.to_s
        @nomeUltima = @diapositivaUltima.id.to_s
        @nomeFicheiroSeguinte = @path + @nomeSeguinte + @extension
        @nomeFicheiroUltimo = @path + @nomeUltima + @extension
        @direcionFicheiroSeguinte = @pathCompleto + @nomeSeguinte + @extension
        @direcionFicheiroUltimo = @pathCompleto + @nomeUltima + @extension
        #A última diapositiva apuntará á segunda (seguinte)
          #Cárganse as liñas
          linas = IO.readlines(@nomeFicheiroUltimo)
           #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
          #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
          File.open(@nomeFicheiroUltimo, 'w') do |f|
            linas.each{ |linea| f.puts(linea) }
          end
          #Ábrese o ficheiro para engadir o novo apuntamento
          File.open(@nomeFicheiroUltimo, 'a+') do |f|
            #Contén vídeo a diapositiva?
                eVideo = false
                @diapositivaUltima.campos_formatos_subformatos_diapositivas.each do |cfsd|
                  @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
                  if @campo.tipo == 'Vídeo'
                    eVideo = true
                    break
                  end
                end

                if eVideo == true
                  f.puts("<script type=\"text/javascript\">\n\t" +
                          "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                          "});\n\n\t" +
                          "</script>\n\n\n\n")
                else
                  f.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, " + @rexistroUltimo.factorTempo.to_i.to_s + "000);\n" +
                      "</script>")
                end
          end
        #Eliminación do rexistro
        @rexistroActual.destroy
        #Eliminación do ficheiro
        File.delete(@nomeFicheiroActual)
        #Actualización das ordes
          #Collemos de novo os rexistros
          @rexistrosCambiar = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
          @rexistrosCambiar.each_with_index do |rexistroCambiar,i|
            rexistroCambiar.update_attributes!(:orde => i+1)
          end
        #A URL de comezo da lista é necesario actualizala
        @listareproducion.update_attributes!(:urlComezo => "public/listas/#{@listareproducion.id}/#{@rexistrosCambiar[0].diapositiva_id}.html")
        
      #1.2 SI O REXISTRO É O ÚLTIMO
      elsif @rexistroActual.orde == @rexistros.length
        #Datos necesarios: anterior e primeira posicións
        @rexistroAnterior = @rexistros[@rexistroActual.orde-2]
        @rexistroPrimeiro = @rexistros[0]
        @diapositivaAnterior = Diapositiva.find(@rexistroAnterior.diapositiva_id)
        @diapositivaPrimeira = Diapositiva.find(@rexistroPrimeiro.diapositiva_id)
        @nomeAnterior = @diapositivaAnterior.id.to_s
        @nomePrimeira = @diapositivaPrimeira.id.to_s
        @nomeFicheiroAnterior = @path + @nomeAnterior + @extension
        @nomeFicheiroPrimeiro = @path + @nomePrimeira + @extension
        @direcionFicheiroAnterior = @pathCompleto + @nomeAnterior + @extension
        @direcionFicheiroPrimeiro = @pathCompleto + @nomePrimeira + @extension
        #A anterior diapositiva apuntará á primeira
          #Cárganse as liñas
          linas = IO.readlines(@nomeFicheiroAnterior)
           #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
          #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
          File.open(@nomeFicheiroAnterior, 'w') do |f|
            linas.each{ |linea| f.puts(linea) }
          end
          #Ábrese o ficheiro para engadir o novo apuntamento
          File.open(@nomeFicheiroAnterior, 'a+') do |f|
            #Contén vídeo a diapositiva?
            eVideo = false
            @diapositivaAnterior.campos_formatos_subformatos_diapositivas.each do |cfsd|
              @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
              if @campo.tipo == 'Vídeo'
                eVideo = true
                break
              end
            end

            if eVideo == true
              f.puts("<script type=\"text/javascript\">\n\t" +
                      "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                      "});\n\n\t" +
                      "</script>\n\n\n\n")
            else
              f.puts("<script type=\"text/javascript\">\n\t" +
                          "function redirectLink() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroPrimeiro + "\");\n\t" +
                          "}\n\n\t" +

                          "setTimeout(function () {\n\t\t" +
                            "redirectLink();\n\t" +
                          "}, " + @rexistroAnterior.factorTempo.to_i.to_s + "000);\n" +
                          "</script>")
            end
          end
        #Eliminación do rexistro
        @rexistroActual.destroy
        #Eliminación do ficheiro
        File.delete(@nomeFicheiroActual)
        #Actualización das ordes
          #Collemos de novo os rexistros
          @rexistrosCambiar = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
          @rexistrosCambiar.each_with_index do |rexistroCambiar,i|
            rexistroCambiar.update_attributes!(:orde => i+1)
          end

      #1.3 SI O REXISTRO É UN INTERMEDIO
      else
        #Datos necesarios: anterior e seguinte posicións
        @rexistroAnterior = @rexistros[@rexistroActual.orde-2]
        @rexistroSeguinte = @rexistros[@rexistroActual.orde]
        @diapositivaAnterior = Diapositiva.find(@rexistroAnterior.diapositiva_id)
        @diapositivaSeguinte = Diapositiva.find(@rexistroSeguinte.diapositiva_id)
        @nomeAnterior = @diapositivaAnterior.id.to_s
        @nomeSeguinte = @diapositivaSeguinte.id.to_s
        @nomeFicheiroAnterior = @path + @nomeAnterior + @extension
        @nomeFicheiroSeguinte = @path + @nomeSeguinte + @extension
        @direcionFicheiroAnterior = @pathCompleto + @nomeAnterior + @extension
        @direcionFicheiroSeguinte = @pathCompleto + @nomeSeguinte + @extension
        #A anterior diapositiva apuntará á seguinte
          #Cárganse as liñas
          linas = IO.readlines(@nomeFicheiroAnterior)
           #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
          #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
          File.open(@nomeFicheiroAnterior, 'w') do |f|
            linas.each{ |linea| f.puts(linea) }
          end
          #Ábrese o ficheiro para engadir o novo apuntamento
          File.open(@nomeFicheiroAnterior, 'a+') do |f|
          #Contén vídeo a diapositiva?
            eVideo = false
            @diapositivaAnterior.campos_formatos_subformatos_diapositivas.each do |cfsd|
              @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
              if @campo.tipo == 'Vídeo'
                eVideo = true
                break
              end
            end

            if eVideo == true
              f.puts("<script type=\"text/javascript\">\n\t" +
                      "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                      "});\n\n\t" +
                      "</script>\n\n\n\n")
            else
              f.puts("<script type=\"text/javascript\">\n\t" +
                          "function redirectLink() {\n\t\t" +
                            "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                          "}\n\n\t" +

                          "setTimeout(function () {\n\t\t" +
                            "redirectLink();\n\t" +
                          "}, " + @rexistroAnterior.factorTempo.to_i.to_s + "000);\n" +
                          "</script>")
            end
          end
        #Eliminación do rexistro
        @rexistroActual.destroy
        #Eliminación do ficheiro
        File.delete(@nomeFicheiroActual)
        #Actualización das ordes
          #Collemos de novo os rexistros
          @rexistrosCambiar = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
          @rexistrosCambiar.each_with_index do |rexistroCambiar,i|
            rexistroCambiar.update_attributes!(:orde => i+1)
          end
      end

    #2 SI HAI DOUS REXISTROS
    elsif @rexistros.length == 2
      #2.1 SI É O PRIMEIRO REXISTRO
      if @rexistroActual.orde == 1
        #Datos necesarios: seguinte posición
        @rexistroSeguinte = @rexistros[@rexistroActual.orde]
        @diapositivaSeguinte = Diapositiva.find(@rexistroSeguinte.diapositiva_id)
        @nomeSeguinte = @diapositivaSeguinte.id.to_s
        @nomeFicheiroSeguinte = @path + @nomeSeguinte + @extension
        @direcionFicheiroSeguinte = @pathCompleto + @nomeSeguinte + @extension
        #A diapositiva que queda non apuntará cara ningunha
          #Cárganse as liñas
          linas = IO.readlines(@nomeFicheiroSeguinte)
          #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
          #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
          File.open(@nomeFicheiroSeguinte, 'w') do |f|
            linas.each{ |linea| f.puts(linea) }
          end
          #Ábrese o ficheiro para engadir o novo apuntamento
          File.open(@nomeFicheiroSeguinte, 'a+') do |f|
            #Contén vídeo a diapositiva?
                eVideo = false
                @diapositivaActual.campos_formatos_subformatos_diapositivas.each do |cfsd|
                  @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
                  if @campo.tipo == 'Vídeo'
                    eVideo = true
                    break
                  end
                end

                if eVideo == true
                  f.puts("<script type=\"text/javascript\">\n\t" +
                          "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                            "//window.location.replace();\n\t" +
                          "});\n\n\t" +
                          "</script>\n\n\n\n")
                else
            f.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, -1);\n" +
                      "</script>")
            end
          end
        #Eliminación do rexistro
        @rexistroActual.destroy
        #Eliminación do ficheiro
        File.delete(@nomeFicheiroActual)
        #Actualización das ordes
          #Collemos de novo os rexistros
          @rexistrosCambiar = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
          @rexistrosCambiar.each_with_index do |rexistroCambiar,i|
            rexistroCambiar.update_attributes!(:orde => i+1)
          end
        #A URL de comezo da lista é necesario actualizala
        @listareproducion.update_attributes!(:urlComezo => "public/listas/#{@listareproducion.id}/#{@rexistrosCambiar[0].diapositiva_id}.html")



      #2.2 SI É O SEGUNDO REXISTRO
      else
        #Datos necesarios: posición anterior
        @rexistroAnterior = @rexistros[@rexistroActual.orde - 2]
        @diapositivaAnterior = Diapositiva.find(@rexistroAnterior.diapositiva_id)
        @nomeAnterior = @diapositivaAnterior.id.to_s
        @nomeFicheiroAnterior = @path + @nomeAnterior + @extension
        @direcionFicheiroAnterior = @pathCompleto + @nomeAnterior + @extension

        #A diapositiva actual non apuntará a ningunha
        #Cárganse as liñas
          linas = IO.readlines(@nomeFicheiroAnterior)
           #Elimínanse as últimas 9 liñas (script redirección)
            var = 1
            while var < 10
              linas.delete_at(linas.length-1)
              var += 1
            end
          #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
          File.open(@nomeFicheiroAnterior, 'w') do |f|
            linas.each{ |linea| f.puts(linea) }
          end
          #Ábrese o ficheiro para engadir o novo apuntamento
          File.open(@nomeFicheiroAnterior, 'a+') do |f|
          #Contén vídeo a diapositiva?
          eVideo = false
          @diapositivaActual.campos_formatos_subformatos_diapositivas.each do |cfsd|
            @campo = Campo.find(cfsd.campos_formatos_subformatos_campos_formatos_campo_id)
            if @campo.tipo == 'Vídeo'
              eVideo = true
              break
            end
          end

          if eVideo == true
            f.puts("<script type=\"text/javascript\">\n\t" +
                    "$(\"#video\").bind(\"ended\", function() {\n\t\t" +
                      "//window.location.replace();\n\t" +
                    "});\n\n\t" +
                    "</script>\n\n\n\n")
          else
            f.puts("<script type=\"text/javascript\">\n\t" +
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace(\"" + @direcionFicheiroSeguinte + "\");\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, -1);\n" +
                      "</script>")
            end
          end
        #Eliminación do rexistro
        @rexistroActual.destroy
        #Eliminación do ficheiro
        File.delete(@nomeFicheiroActual)
        #Collemos de novo os rexistros
          @rexistrosCambiar = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => 'orde')
          @rexistrosCambiar.each_with_index do |rexistroCambiar,i|
            rexistroCambiar.update_attributes!(:orde => i+1)
          end
      end

    #3 SI SÓ HAI UN REXISTRO
    else
      #Eliminar rexistro
      @rexistroActual.destroy
      #Eliminar ficheiro
      File.delete(@nomeFicheiroActual)
      @listareproducion.update_attributes!(:urlComezo => '')
    end
    flash[:notificacion] = "Lista de reprodución actualizada con éxito."
    redirect_to edit_listareproducion_path(@listareproducion)
  end

end
