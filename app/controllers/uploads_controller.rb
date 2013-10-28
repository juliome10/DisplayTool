# encoding: utf-8

class UploadsController < ApplicationController
  def index
    #Imaxes en directorio
    @imaxes = Dir.glob("app/assets/images/usuario/*")
    #Vídeos en directorio
    @videos = Dir.glob("public/videos/*")
  end

  def uploadFile
      post = DataFile.save(params[:upload])
      flash[:notificacion] = "Contido subido con éxito!"
      redirect_to :controller => 'uploads', :action => 'index'
  end
end