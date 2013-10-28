class DataFile < ActiveRecord::Base
    attr_accessor :upload

    def self.save(upload)
      #Extensións de vídeo aceptadas para html5
      @extVideo = [".webm", ".ogg", ".mp4"]

      name = upload['datafile'].original_filename
      extension = File.extname(upload['datafile'].original_filename)

      #Configuración do directorio segundo o tipo de ficheiro
      if @extVideo.include?(extension)
        directory = 'public/videos'
      else
        directory = 'app/assets/images/usuario'
      end
      
      # create the file path
      path = File.join(directory,name)
      # write the file
      File.open(path, "wb") {|f| f.write(upload['datafile'].read) }

    end
end