# encoding: utf-8
class FormatosController < ApplicationController

  def show
    #Datos do formato
    @formato = Formato.find(params[:id])
    #Subformatos do formato
    #@subformatos = Subformato.find_all_by_formato_id(params[:id])
  end

  def index
    @formatos = Formato.all
 end

  def new
    @dispositivosloxicos = Dispositivoloxico.all
  end

  def create
    #Crease o formato
    @formato = Formato.create!(:nome => params[:nome], :descricion => params[:descricion])
    #Recíbense os dispositivos para os que se crearán os subformatos
    @dispositivos = params[:dispositivo]
    #Para cada dispositivo, crease o subformato, no caso de que se especificase algún.
    if !@dispositivos.nil?
      @dispositivos.each do |dispositivo|
        @subformato = Subformato.create!(:formato_id => @formato.id, :dispositivoloxico_id => dispositivo)
      end
    end
    redirect_to :controller => 'formatos', :action => 'show', :id => @formato.id
  end

  def edit
    @dispositivosSenSubformato = Array.new
    #Selecionase o formato
    @formato = Formato.find params[:id]
    #Recollense os dispositivos existentes
    @dispositivosloxicos = Dispositivoloxico.all
    #Compróbase para que dispositivos non hai subformato creado. (Para dar a opción a crealos na vista).
    @dispositivosloxicos.each do |dispositivo|
      @encontrado = false
      @formato.subformatos.each do |subformato|
        if subformato.dispositivoloxico.id == dispositivo.id
          @encontrado = true
        end
      end
      if @encontrado == false
        @dispositivosSenSubformato << dispositivo
      else
      end
    end
  end

  def update
    @formato = Formato.find(params[:id])
    @formato.update_attributes!(:nome => params[:nome], :descricion => params[:descricion])
    flash[:notificacion] = "O formato foi actualizado con éxito."
    redirect_to formato_path(@formato)
  end

  def destroy
    @formato = Formato.find(params[:id])
    @formato.destroy

    #Eliminar as entradas de campos_formatos_subformatos (join-join non borra automáticamente)
    @rexistros = CamposFormatosSubformato.find_all_by_campos_formatos_formato_id(params[:id])
    @rexistros.each do |rexistro|
      rexistro.destroy
    end
    flash[:notificacion] = "Formato eliminado con éxito."
    redirect_to formatos_path
  end

end
