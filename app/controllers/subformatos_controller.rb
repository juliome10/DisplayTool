# encoding: utf-8
class SubformatosController < ApplicationController

  def index
    #No caso de que se queiran consultar todas as tuplas sen filtro de formato
    if params[:idFormato].nil?
      @subformatos = Subformato.all
    else
      @subformatos = Subformato.find_all_by_formato_id(params[:idFormato], :order => "dispositivoloxico_id")
    end
  end

  def show
    @subformato = Subformato.find(params[:id])
    if (@subformato.dispositivoloxico.relacionAspectoHorizontal == 4)
      @width = 320
      @height = 240
    elsif (@subformato.dispositivoloxico.relacionAspectoHorizontal == 3)
      @width = 240
      @height = 320
    elsif (@subformato.dispositivoloxico.relacionAspectoHorizontal == 16)
      @width = 320
      @height = 180
    end
  end

  def new
	session[:idFormato] = params[:idFormato]
	create()
  end

  def edit
    @subformato = Subformato.find(params[:id])
  end

  def create
    #Recíbense os parámetros (formato e dispositivos).
    @idFormato = params[:idFormato]
    @dispositivos = params[:dispositivo]
    #Cóllense os campos do formato.
    @campos = Formato.find(@idFormato).campos
    #Crease o subformato para o formato e dispositivos escollidos.
    if !@dispositivos.nil?
      @dispositivos.each do |dispositivo|
        @subformato = Subformato.create!(:formato_id => @idFormato, :dispositivoloxico_id => dispositivo)
        #A maiores, crearase unha entrada en campos_formatos_subformatos para gardar os datos das posicións e lonxitudes.
        @campos.each do |campo|
          #Compróbase que non exista xa
          @existe = CamposFormatosSubformato.find_all_by_campos_formatos_formato_id_and_subformato_id_and_campos_formatos_campo_id(@formato,@subformato,@campo)
          if @existe.empty? 
            CamposFormatosSubformato.create!(:campos_formatos_formato_id => @subformato.formato.id, :campos_formatos_campo_id => campo.id, :subformato_id => @subformato.id, :posicionX => 0, :posicionY => 0, :lonxitudeX => 0, :lonxitudeY => 0)
          end
        end
      end
    flash[:notificacion] = "Crearonse os subformatos correspondentes con éxito."
    end
    redirect_to :controller => 'formatos', :action => 'edit', :id => @idFormato
  end

  def update
    #Recóllense os datos do formulario.
    @subformato = params[:subformato_id]
    #Actualízanse os datos
    @campos_formatos_subformato = CamposFormatosSubformato.find(params[:rexistro_id])
    @campos_formatos_subformato.update_attributes!(:posicionX => params[:posicionX], :posicionY => params[:posicionY], :lonxitudeX => params[:lonxitudeX], :lonxitudeY => params[:lonxitudeY])
    flash[:notificacion] = "Actualizaronse os datos con éxito."
    redirect_to :controller => "subformatos", :action => "show", :id => @subformato
  end

  def destroy
    @subformato = Subformato.find(params[:id])
    @idFormato = @subformato.formato_id
    @subformato.destroy
    redirect_to :controller => "subformatos", :action => "index", :idFormato => @idFormato
  end
end
