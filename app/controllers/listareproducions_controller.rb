# encoding: utf-8

class ListareproducionsController < ApplicationController
  # GET /listareproducions
  # GET /listareproducions.json
  def index
    #Recóllense todas as listas de reprodución
    @listareproducions = Listareproducion.all
    #Recóllense todos os dispositivos das listas
    @dispositivos = Array.new

    #Búsqueda do tipo de dispositivo para o que foi deseñada cada lista
    @listareproducions.each do |listareproducion|
    #Cóllese a primeira diapositiva e consúltase o dispositivo ó que pertence o subformato de esta
    @listareproducion_diapositivas = DiapositivasListareproducion.find_all_by_listareproducion_id(listareproducion.id)
    if !@listareproducion_diapositivas.empty?
      @diapositiva = Diapositiva.find(@listareproducion_diapositivas[0].diapositiva_id)
      @diapositiva_formato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id
      @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
      @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
      @dispositivos << @dispositivo
    end
    end
  end

  # GET /listareproducions/1
  # GET /listareproducions/1.json
  def show
    #Lista de reprodución
    @listareproducion = Listareproducion.find(params[:id])
    #Diapositivas da lista
    @listareproducion_diapositivas = Array.new
    #Formatos das diapositivas da lista
    @listareproducion_formatos = Array.new
    @listareproducion_rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => "orde")

    @listareproducion_rexistros.each do |rexistro|
      @listareproducion_diapositivas << Diapositiva.find(rexistro.diapositiva_id)
      @listareproducion_formatos << Formato.find(Diapositiva.find(rexistro.diapositiva_id).campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    end

    #Búsqueda do tipo de dispositivo para o que foi deseñada, se xa ten
    if !@listareproducion_diapositivas.empty?
      @diapositiva = Diapositiva.find(@listareproducion_diapositivas[0].id)
      @diapositiva_formato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id
      @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
      @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
    end
   
  end

  # GET /listareproducions/new
  # GET /listareproducions/new.json
  def new
    #Nova lista
    @listareproducion = Listareproducion.new
    #Recóllense todos os dispositivos lóxicos
    @dispositivoloxicos = Dispositivoloxico.all
    if params[:dispositivo]
      @dispositivo = Dispositivoloxico.find(params[:dispositivo])
      #Escoller as diapositivas adaptadas a ese dispositivo
        #Primeiro recóllense os subformatos creados para dito dispositivo
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
            @diapositivas << @diapositiva
            @diapositivas_formatos << Formato.find(@diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
            @opcionsSelect << @diapositiva.id
          end
        end
    end
  end

  # GET /listareproducions/1/edit
  def edit
    #Lista de reprodución
    @listareproducion = Listareproducion.find(params[:id])
    #Diapositivas da lista
    @listareproducion_diapositivas = Array.new
    #Formatos das diapositivas da lista
    @listareproducion_formatos = Array.new
    @listareproducion_rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id, :order => "orde")

    @listareproducion_rexistros.each do |rexistro|
      @listareproducion_diapositivas << Diapositiva.find(rexistro.diapositiva_id)
      @listareproducion_formatos << Formato.find(Diapositiva.find(rexistro.diapositiva_id).campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id)
    end

    #Búsqueda do tipo de dispositivo para o que foi deseñada, se xa ten diapositivas
    if !@listareproducion_diapositivas.empty?
      @diapositiva = Diapositiva.find(@listareproducion_diapositivas[0].id)
      @diapositiva_formato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_campos_formatos_formato_id
      @diapositiva_subformato = @diapositiva.campos_formatos_subformatos_diapositivas[0].campos_formatos_subformatos_subformato_id
      @dispositivo = Subformato.find(@diapositiva_subformato).dispositivoloxico
    end
  end

  # POST /listareproducions
  # POST /listareproducions.json
  def create
    @listareproducion = Listareproducion.create!(:nome => params[:nome])
    DiapositivasListareproducion.create!(:diapositiva_id => params[:diapositiva], :listareproducion_id => @listareproducion.id, :factorTempo => params[:factorTempoDiapositiva], :orde => '1')

    #Crear carpeta para a lista
    Dir.mkdir"public/listas/#{@listareproducion.id}"
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
      redireccion = "<script type=\"text/javascript\">\n\t" + 
                      "function redirectLink() {\n\t\t" +
                        "window.location.replace();\n\t" +
                      "}\n\n\t" +

                      "setTimeout(function () {\n\t\t" +
                        "redirectLink();\n\t" +
                      "}, -1);\n" +
                      "</script>"
      outFile.puts(redireccion)
      outFile.close
    flash[:notificacion] = "Lista de reprodución creada con éxito."
    redirect_to :controller => "listareproducions", :action => :edit, :id => @listareproducion.id
  end

  # PUT /listareproducions/1
  # PUT /listareproducions/1.json
  def update
    @listareproducion = Listareproducion.find(params[:id])
    @listareproducion.update_attributes!(:nome => params[:nome])
    flash[:notificacion] = "Lista de reprodución actualizada con éxito."
    redirect_to listareproducion_path(@listareproducion)
  end

  # DELETE /listareproducions/1
  # DELETE /listareproducions/1.json
  def destroy
    #Búscase a lista
    @listareproducion = Listareproducion.find(params[:id])
    #Gárdase o id
    @id = @listareproducion.id
    
    #Eliminar os rexistros da relación diapositivas - listas de reprodución
    @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@id)
    @rexistros.each do |rexistro|
      rexistro.destroy
    end
    

    #Eliminar ficheiros estáticos da carpeta public
    FileUtils.rm_rf("public/listas/#{@id}/")

    #Elimínase a lista
    @listareproducion.destroy

    flash[:notificacion] = "Lista de reproducion eliminada con éxito."
    redirect_to listareproducions_path
  end
end
