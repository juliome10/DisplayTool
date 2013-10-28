# encoding: utf-8

class EstilosController < ApplicationController
  # GET /estilos
  # GET /estilos.json
  def index
    @estilos = Estilo.all

  end

  # GET /estilos/1
  # GET /estilos/1.json
  def show
    @estilo = Estilo.find(params[:id])
    @valores = CamposEstilo.find_all_by_estilo_id(@estilo.id)
  end

  # GET /estilos/new
  # GET /estilos/new.json
  def new
    @estilo = Estilo.new
    @background_position_options = ['','Esquerda Arriba','Esquerda Centro', 'Esquerda Abaixo', 'Dereita Arriba', 'Dereita Centro', 'Dereita Abaixo', 'Centro Arriba', 'Centro Centro', 'Centro Abaixo', 'Posicion X Posicion Y', '%x %y']
    @background_repeat_options = ['','Repetir X e Y', 'Repetir X', 'Repetir Y', 'Non repetir']
    @background_size_options = ['','Cover', 'Contain', 'X pixels Y pixels', 'Pixels', '%x %y', 'Porcentaxe']
    #Imaxes en directorio
    @imaxes = Dir.glob("app/assets/images/usuario/*")
  end

  # GET /estilos/1/edit
  def edit
    @estilo = Estilo.find(params[:id])
    @valores = CamposEstilo.find_all_by_estilo_id(@estilo.id)
    @alinadosHorizontal = ['Esquerda','Dereita','Centrado','Xustificado']
    @alinadosVertical = ['Arriba','Centro','Abaixo']
    @fontes = ['Comic Sans MS','Verdana','Palatino','Arial','Helvetica Neue']
    @background_position_options = ['','Esquerda Arriba','Esquerda Centro', 'Esquerda Abaixo', 'Dereita Arriba', 'Dereita Centro', 'Dereita Abaixo', 'Centro Arriba', 'Centro Centro', 'Centro Abaixo', 'Posicion X Posicion Y', '%x %y']
    @background_repeat_options = ['','Repetir X e Y', 'Repetir X', 'Repetir Y', 'Non repetir']
    @background_size_options = ['','Cover', 'Contain', 'X pixels Y pixels', 'Pixels', '%x %y', 'Porcentaxe']
    #Imaxes en directorio
    @imaxes = Dir.glob("app/assets/images/usuario/*")
  end

  # POST /estilos
  # POST /estilos.json
  def create
    #Creación do estilo
    @estilo = Estilo.create(:nome => params[:nome], :descricion => params[:descricion])
    #No caso de que se especificara algunha propiedade, almacenarase
    if !params[:background_color].empty?
      @estilo.update_attributes!(:background_color => params[:background_color])
    end
    if !params[:background_image].empty?
      @estilo.update_attributes!(:background_image => params[:background_image])
    end
    if !params[:background_position].empty?
      @estilo.update_attributes!(:background_position => params[:background_position])
      if !params[:background_position_x].empty?
        @estilo.update_attributes!(:background_position_x => params[:background_position_x])
      end
      if !params[:background_position_y].empty?
        @estilo.update_attributes!(:background_position_y => params[:background_position_y])
      end
    end
    if !params[:background_repeat].empty?
      @estilo.update_attributes!(:background_repeat => params[:background_repeat])
    end
    if !params[:background_size].empty?
      @estilo.update_attributes!(:background_size => params[:background_size])
      if !params[:background_size_x].empty?
        @estilo.update_attributes!(:background_size_x => params[:background_size_x])
      end
      if !params[:background_size_y].empty?
        @estilo.update_attributes!(:background_size_y => params[:background_size_y])
      end
      if !params[:background_size_val].empty?
        @estilo.update_attributes!(:background_size_val => params[:background_size_val])
      end
    end
    
    #Todo estilo terá propiedades para cada campo do tipo texto
    @campos = Campo.find_all_by_tipo('Texto')
    @campos.each do |campo|
      #Inicialízase cos valores por defecto (parámetros de configuración)
      if campo.subtipo == 'Título'
        CamposEstilo.create!(:campo_id => campo.id, :estilo_id => @estilo.id, :fonte => Parametro.find_by_variable('titulo_fonte').valor, :tamano => Parametro.find_by_variable('titulo_tamano').valor, :cor => Parametro.find_by_variable('titulo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('titulo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('titulo_alinadoVertical').valor)
      elsif campo.subtipo == 'Subtítulo'
        CamposEstilo.create!(:campo_id => campo.id, :estilo_id => @estilo.id, :fonte => Parametro.find_by_variable('subtitulo_fonte').valor, :tamano => Parametro.find_by_variable('subtitulo_tamano').valor, :cor => Parametro.find_by_variable('subtitulo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('subtitulo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('subtitulo_alinadoVertical').valor)
      elsif campo.subtipo == 'Resumo'
        CamposEstilo.create!(:campo_id => campo.id, :estilo_id => @estilo.id, :fonte => Parametro.find_by_variable('resumo_fonte').valor, :tamano => Parametro.find_by_variable('resumo_tamano').valor, :cor => Parametro.find_by_variable('resumo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('resumo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('resumo_alinadoVertical').valor)
      elsif campo.subtipo == 'Descrición'
        CamposEstilo.create!(:campo_id => campo.id, :estilo_id => @estilo.id, :fonte => Parametro.find_by_variable('descricion_fonte').valor, :tamano => Parametro.find_by_variable('descricion_tamano').valor, :cor => Parametro.find_by_variable('descricion_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('descricion_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('descricion_alinadoVertical').valor)
      elsif campo.subtipo == 'Pé'
        CamposEstilo.create!(:campo_id => campo.id, :estilo_id => @estilo.id, :fonte => Parametro.find_by_variable('pe_fonte').valor, :tamano => Parametro.find_by_variable('pe_tamano').valor, :cor => Parametro.find_by_variable('pe_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('pe_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('pe_alinadoVertical').valor)
      end
    end
    flash[:notificacion] = "Estilo creado con éxito"
    redirect_to edit_estilo_path(@estilo)
  end
  
  def update
    @estilo = Estilo.find(params[:id])

    #Actualízanse os valores
    if params[:accion] == 'datos'
      @estilo.update_attributes!(:nome => params[:nome], :descricion => params[:descricion])
    elsif params[:accion] == 'fondo'
      @estilo.update_attributes!(:background_color => params[:background_color], :background_image => params[:background_image], :background_repeat => params[:background_repeat], :background_position => params[:background_position], :background_size => params[:background_size])

      #No caso de que se facilitaran valores adicionais, actualízanse, senón, limpanse os campos da bd
      if params[:background_position] == 'Posicion X Posicion Y' || params[:background_position] == '%x %y'
        @estilo.update_attributes!(:background_position_x => params[:background_position_x], :background_position_y => params[:background_position_y])
      else
        @estilo.update_attributes!(:background_position_x => '', :background_position_y => '')
      end

      #No caso de que se facilitaran valores adicionais, actualízanse, senón, limpanse os campos da bd
      if params[:background_size] == 'X Pixels Y Pixels' || params[:background_size] == '%x %y'
        @estilo.update_attributes!(:background_size_x => params[:background_size_x], :background_size_y => params[:background_size_y])
        @estilo.update_attributes!(:background_size_val => '')
      elsif params[:background_size] == 'Pixels' || params[:background_size] == 'Porcentaxe'
        @estilo.update_attributes!(:background_size_val => params[:background_size_val])
        @estilo.update_attributes!(:background_size_x => '', :background_size_y => '')
      else
        @estilo.update_attributes!(:background_size_x => '', :background_size_y => '', :background_size_val => '')
      end

    #No caso de que se actualicen as propiedades para cada campo
    else
      #Recóllense os datos
      @fontes = params[:fontes]
      @tamanos = params[:tamanos]
      @cores = params[:cores]
      @idsCampo = params[:idCampo]
      @alignsH = params[:alinadosH]
      @alignsV = params[:alinadosV]
      
      #Recórrense os  valores
      @fontes.each_with_index do |fonte,i|
        #Recupérase o rexistro
        @rexistro = CamposEstilo.find_by_estilo_id_and_campo_id(@estilo.id,@idsCampo[i])
        #Actualízase o rexistro
        @rexistro.update_attributes!(:fonte => fonte, :tamano => @tamanos[i], :cor => @cores[i], :alinadoHorizontal => @alignsH[i], :alinadoVertical => @alignsV[i])
      end
    end
    flash[:notificacion] = "O estilo actualizouse con éxito."
    redirect_to estilo_path(@estilo)
  end

  # DELETE /estilos/1
  # DELETE /estilos/1.json
  def destroy
    @estilo = Estilo.find(params[:id])
    @estilo.destroy

    #Eliminar entradas de campos_estilos
    @rexistros = CamposEstilo.find_all_by_estilo_id(params[:id])
    @rexistros.each do |rexistro|
      rexistro.destroy
    end
    flash[:notificacion] = "Estilo eliminado con éxito"
    redirect_to estilos_path
  end
end
