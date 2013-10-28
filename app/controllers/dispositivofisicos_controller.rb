# encoding: utf-8
class DispositivofisicosController < ApplicationController
  # GET /dispositivofisicos
  # GET /dispositivofisicos.json
  def index
    @dispositivofisicos = Dispositivofisico.all 
  end

  # GET /dispositivofisicos/1
  # GET /dispositivofisicos/1.json
  def show
    @dispositivofisico = Dispositivofisico.find(params[:id])
  end

  # GET /dispositivofisicos/new
  # GET /dispositivofisicos/new.json
  def new
    @dispositivofisico = Dispositivofisico.new
    #Dispositivos lóxicos ós que poderá pertencer
    @dispositivoloxicos = Dispositivoloxico.all
    #Opcións para o select
    @opcions = Array.new
    @dispositivoloxicos.each do |dispositivoloxico|
      @opcions << dispositivoloxico.relacionAspectoHorizontal.to_s + ":" + dispositivoloxico.relacionAspectoVertical.to_s
    end
  end

  # GET /dispositivofisicos/1/edit
  def edit
    @dispositivofisico = Dispositivofisico.find(params[:id])
    #Lista asignada?
    if !@dispositivofisico.listareproducion.nil?
      @listareproducion = Listareproducion.find(@dispositivofisico.listareproducion.id)
    end
    #Opcións para o select
    @opcions = Array.new
    #Dispositivos lóxicos ós que poderá pertencer
    @dispositivoloxicos = Dispositivoloxico.all
    @dispositivoloxicos.each do |dispositivoloxico|
      @opcions << dispositivoloxico.relacionAspectoHorizontal.to_s + ":" + dispositivoloxico.relacionAspectoVertical.to_s
    end
    #Existente
    @selecionado = @dispositivofisico.dispositivoloxico.relacionAspectoHorizontal.to_s + ":" + @dispositivofisico.dispositivoloxico.relacionAspectoVertical.to_s

    #Listas de reprodución que se darán a escoller
    @listasPosibles = Array.new
    @opcionsListas = Array.new

    #Recóllense todas as listas de reprodución
    @listareproducions = Listareproducion.all

    #Búsqueda do tipo de dispositivo para o que foi deseñada cada lista
    @listareproducions.each do |listareproducion|
      #Cóllese a primeira diapositiva e consúltase o dispositivo ó que pertence o subformato de esta
      @listareproducion_diapositivas = DiapositivasListareproducion.find_all_by_listareproducion_id(listareproducion.id)
      if !@listareproducion_diapositivas.empty?
        @diapositiva = Diapositiva.find(@listareproducion_diapositivas[0].diapositiva_id)
        @diapositiva_formato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id
        @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
        @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
        if (@dispositivo.id == @dispositivofisico.dispositivoloxico.id)
          if @dispositivofisico.listareproducion.nil?
              @listasPosibles << listareproducion
              @opcionsListas << listareproducion.id
          else
            if @dispositivofisico.listareproducion.id != listareproducion.id
              @listasPosibles << listareproducion
              @opcionsListas << listareproducion.id
            end
          end
        end
      end
    end
  end

  # POST /dispositivofisicos
  # POST /dispositivofisicos.json
  def create
    @stringDispositivo = params[:dispositivoLoxico]
    @stringCortada = @stringDispositivo.split(':')
    @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(@stringCortada[0], @stringCortada[1])

    #Creación do dispositivo físico
    @dispositivofisico = Dispositivofisico.create!(:nome => params[:nome], :descricion => params[:descricion], :situacion => params[:situacion], :dispositivoloxico_id => @dispositivoloxico.id)
    #Creación da carpeta e ficheiro de arranque
    Dir.mkdir"public/dispositivos/#{@dispositivofisico.id}"
    @url = "public/dispositivos/#{@dispositivofisico.id}/inicio.html"
    outFile = File.new(@url, "w")
    @imprimir = "<!DOCTYPE html>\n" +
                "<meta http-equiv=\"refresh\" content=\"0;url=\">"
    outFile.puts(@imprimir)
    #Actualización do atributo que almacena o ficheiro
    @dispositivofisico.update_attributes!(:url => @url)
    #Notificación e redirección
    flash[:notificacion] = "Dispositivo creado con éxito."
    redirect_to dispositivofisicos_path
  end

  # PUT /dispositivofisicos/1
  # PUT /dispositivofisicos/1.json
  def update
    @dispositivofisico = Dispositivofisico.find(params[:id])
    
    #Modificación de datos
    if params[:accion] == 'datos'
       #Recuperación do dispositivo lóxico desexado
      @stringDispositivo = params[:dispositivoLoxico]
      @stringCortada = @stringDispositivo.split(':')
      @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(@stringCortada[0], @stringCortada[1])
      @dispositivofisico.update_attributes!(:nome => params[:nome], :descricion => params[:descricion], :situacion => params[:situacion], :dispositivoloxico_id => @dispositivoloxico.id)
    #Asignación dunha lista de reprodución
    elsif params[:accion] == 'lista'
      @dispositivofisico.update_attributes!(:listareproducion_id => params[:listareproducion])
      #Lista de reprodución escollida
      @listareproducion = Listareproducion.find(params[:listareproducion])
      #Url do ficheiro de inicio
      @url = "public/dispositivos/#{@dispositivofisico.id}/inicio.html"

      #Eliminación do que xa había
      #Cárganse as liñas
        linas = IO.readlines(@url)
        #Elimínase a última liña
        linas.delete_at(linas.length-1)
        #Ábrese o ficheiro e escríbense todas as liñas (menos as eliminadas)
        File.open(@url, 'w') do |f|
          linas.each{ |linea| f.puts(linea) }
        end
        #Ábrese o ficheiro para engadir o novo apuntamento
        File.open(@url, 'a+') do |f|
          f.puts("<meta http-equiv=\"refresh\" content=\" 0 ;url=" + @listareproducion.urlComezo + "\">" )
        end

    #Desvinculación dunha lista de reprodución
    elsif params[:accion] == 'desvincular'
      @dispositivofisico.update_attributes!(:listareproducion_id => 'NULL')
      #Url do ficheiro de inicio
      @url = "public/dispositivos/#{@dispositivofisico.id}/inicio.html"

      #Eliminación do que xa había
      #Cárganse as liñas
        linas = IO.readlines(@url)
        #Elimínase a última liña
        linas.delete_at(linas.length-1)
        #Ábrese o ficheiro e escríbense todas as liñas (menos a eliminada)
        File.open(@url, 'w') do |f|
          linas.each{ |linea| f.puts(linea) }
        end
        #Ábrese o ficheiro para engadir o novo apuntamento
        File.open(@url, 'a+') do |f|
          f.puts("<meta http-equiv=\"refresh\" content=\" 0 ;url=\">" )
        end

    end
    #Notificación e redirección
    flash[:notificacion] = "Dispositivo modificado con éxito."
    redirect_to dispositivofisico_path(@dispositivofisico)
  end

  # DELETE /dispositivofisicos/1
  # DELETE /dispositivofisicos/1.json
  def destroy
    @dispositivofisico = Dispositivofisico.find(params[:id])
    #Eliminar ficheiros estáticos da carpeta do dispositivo
    FileUtils.rm_rf("public/dispositivos/#{@dispositivofisico.id}/")
    #Eliminación da base de datos
    @dispositivofisico.destroy
    #Notificación e redirección
    flash[:notificacion] = "Dispositivo eliminado con éxito"
    redirect_to dispositivofisicos_path
  end

end
