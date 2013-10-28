# encoding: utf-8
class DispositivoloxicosController < ApplicationController
  # GET /dispositivo_loxicos
  # GET /dispositivo_loxicos.json
  def index
    	@dispositivoloxicos = Dispositivoloxico.all
  end

  # GET /dispositivo_loxicos/1
  # GET /dispositivo_loxicos/1.json
  def show
    @dispositivoloxico = Dispositivoloxico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dispositivoloxico }
    end
  end

  # GET /dispositivo_loxicos/new
  # GET /dispositivo_loxicos/new.json
  def new
    @dispositivoloxico = Dispositivoloxico.new
  end

  # GET /dispositivo_loxicos/1/edit
  def edit
    @dispositivoloxico = Dispositivoloxico.find(params[:id])
  end

  # POST /dispositivo_loxicos
  # POST /dispositivo_loxicos.json
  def create
    @dispositivoloxico = Dispositivoloxico.create!(:relacionAspectoHorizontal => params[:relacionAspectoHorizontal], :relacionAspectoVertical => params[:relacionAspectoVertical])
    flash[:notificacion] = "Dispositivo creado con éxito."
    redirect_to :controller => 'dispositivoloxicos', :action => 'index'
  end

  # PUT /dispositivo_loxicos/1
  # PUT /dispositivo_loxicos/1.json
  def update
    @dispositivoloxico = Dispositivoloxico.find(params[:id])
    @dispositivoloxico.update_attributes!(:relacionAspectoHorizontal => params[:relacionAspectoHorizontal], :relacionAspectoVertical => params[:relacionAspectoVertical])
    flash[:notificacion] = "O dispositivo foi actualizado con éxito."
    redirect_to dispositivoloxico_path(@dispositivoloxico)
  end

  # DELETE /dispositivo_loxicos/1
  # DELETE /dispositivo_loxicos/1.json
  def destroy
    @dispositivoloxico = Dispositivoloxico.find(params[:id])
    #Eliminar os campos_formatos_subformatos dependentes dos subformatos do dispositivo
    @subformatos = Subformato.find_all_by_dispositivoloxico_id(params[:id])
    @subformatos.each do |subformato|
      @rexistros = CamposFormatosSubformato.find_all_by_subformato_id(subformato.id)
      @rexistros.each do |rexistro|
        rexistro.destroy
      end
    end
    #Esto elimina o dispositivo lóxico e automáticamente os subformatos
    @dispositivoloxico.destroy
    flash[:notificacion] = "Dispositivo eliminado con éxito."
    redirect_to dispositivoloxicos_path
  end
end
