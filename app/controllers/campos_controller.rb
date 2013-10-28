# encoding: utf-8
class CamposController < ApplicationController

  def show
    @campo = Campo.find(params[:id])
  end

  def index
    @campos = Campo.all
    if params[:idFormato]
      @formato = Formato.find(params[:idFormato])
      @rexistros = CamposFormato.find_all_by_formato_id(@formato.id)
    end
 end

  def new
    @tipos =  ['Imaxe','Texto','Vídeo']
    @subtipos =  ['Titulo', 'Subtitulo', 'Resumo', 'Descricion', 'Pe', 'Logo', 'Icono', 'Foto', 'Local', 'Embebido']
  end

  def create
    #Búscase o campo
    @campo = Campo.find(params[:idCampo])
    #Búscase o formato
    @formato = Formato.find(params[:idFormato])
    #Asígnase o campo ó formato. Esto creará a entrada na táboa da relación.
    #@formato.campos << @campo
    @rexistro = CamposFormato.create!(:formato_id => @formato.id, :campo_id => @campo.id)
    #Recóllense os subformatos do formato
    @subformatos = @formato.subformatos
    #Créanse entradas na táboa de campos_formatos_subformatos para almacenar os datos correspondentes a cada campo_formato
    @subformatos.each do |subformato|
      CamposFormatosSubformato.create!(:campos_formatos_formato_id => @formato.id, :campos_formatos_campo_id => @campo.id, :subformato_id => subformato.id, :posicionX => 0, :posicionY => 0, :lonxitudeX => 0, :lonxitudeY => 0, :campos_formato_id => @rexistro.id)
    end
    flash[:notificacion] = "O campo foi asignado con exito."
    redirect_to campos_path(:idFormato => @formato.id)
  end

  def edit
    @campo = Campo.find params[:id]
    @tipos =  ['Imaxe','Texto','Vídeo']
    @subtipos =  ['Titulo', 'Subtitulo', 'Resumo', 'Descricion', 'Pe', 'Logo', 'Icono', 'Foto', 'Local', 'Embebido']
  end

  def update
    @campo = Campo.find params[:id]
    @campo.update_attributes!(:tipo => params[:tipo], :subtipo => params[:subtipo])
    flash[:notificacion] = "O campo con id:#{@campo.id} foi actualizado con exito."
    redirect_to edit_formato_path(@campo.formatos[0].id)
  end

  def destroy
    @campo = Campo.find(params[:id])
    @formato = Formato.find(params[:idFormato])

    #Eliminar as entradas da táboa relación campos - formatos - subformatos
    @rexistros = CamposFormatosSubformato.find_all_by_campos_formatos_campo_id_and_campos_formatos_formato_id(@campo.id, @formato.id)
    @rexistros.each do |rexistro|
      rexistro.destroy
    end

    @rexistros2 = CamposFormato.find_all_by_campo_id_and_formato_id(@campo.id, @formato.id)
    @rexistros2.each do |rexistro2|
      rexistro2.destroy
    end

    flash[:notificacion] = "O campo foi eliminado do formato con exito."
    redirect_to edit_formato_path(@formato)
  end

  def desvincular
    @formato = Formato.find(params[:idFormato])

    @rexistro = CamposFormato.find(params[:rexistro_id])
    @rexistro.destroy
    
    @rexistroCamposFormato = CamposFormatosSubformato.find_all_by_campos_formato_id(params[:rexistro_id])
    @rexistroCamposFormato.each do |rexistro|
      rexistro.destroy
    end

    flash[:notificacion] = "Campo desvinculado con éxito"
    redirect_to campos_path(:idFormato => @formato.id)
  end
end
