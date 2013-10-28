# encoding: utf-8

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/ then '/'
    
    #index
    when /^"([^\"]*)" page$/ then
      case $1
        when "Dispositivos lóxicos" then '/dispositivoloxicos'
        when "Formatos" then '/formatos'
        when "Uploads" then '/uploads'
        when "Estilos" then '/estilos'
        when "Dispositivos físicos" then '/dispositivofisicos'
        when "Diapositivas" then '/diapositivas'
        when "Listas de reprodución" then '/listareproducions'
        when "Parámetros de configuración" then '/parametros'
        when "Arquivos" then '/uploads'
      end
    when /^"Campos" page for "Formato" called "([^\"]*)"$/  then
      @formato = Formato.find_by_nome($1)
      '/campos?idFormato=' + @formato.id.to_s


    #new
    when /^page for create a new "([^\"]*)"$/ then
      case $1
        when "Dispositivo lóxico" then '/dispositivoloxicos/new'
        when "Formato" then '/formatos/new'
        when "Estilo" then '/estilos/new'
        when "Diapositiva" then '/diapositivas/new'
        when "Dispositivo físico" then '/dispositivofisicos/new'
        when "Lista de reprodución" then '/listareproducions/new'
      end
    when /^page for create a new Diapositiva which belongs to "Formato" called "([^\"]*)"$/ then
      @formato = Formato.find_by_nome($1)
      @subformato = Subformato.find_by_formato_id(@formato.id)
      '/diapositivas/new?utf8=%E2%9C%93&subformato[]=' + @subformato.id.to_s + '&idFormato=' + @formato.id.to_s + '&commit=Selecionar'
    when /^page for create a new Lista de reprodución with diapositivas for dispositivo ([^\"]*):([^\"]*)$/ then
      @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical($1,$2)
      '/listareproducions/new?utf8=%E2%9C%93&dispositivo=' + @dispositivoloxico.id.to_s + '&commit=Selecionar'
    when /^page for add "Diapositiva" to "Lista de reprodución" called "([^\"]*)"$/ then
      @listareproducion = Listareproducion.find_by_nome($1)
      '/diapositivas_listareproducions/new?lista=' + @listareproducion.id.to_s


    #show
    when /^page for view details from "Dispositivo lóxico" ([^\"]*):([^\"]*)$/ then
      id = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical($1,$2)
		  dispositivoloxico_path(id)
    when /^page for view details from "Formato" called "([^\"]*)"$/ then
		  formato = Formato.find_by_nome($1)
		  formato_path(formato)
    when /^page for view details from "Estilo" called "([^\"]*)"$/ then
      estilo = Estilo.find_by_nome($1)
      estilo_path(estilo)
    when /^page for view details from "Lista de reprodución" called "([^\"]*)"$/ then
      lista = Listareproducion.find_by_nome($1)
      listareproducion_path(lista)
    when /^"Subformato" page which belongs to "Formato" called "([^\"]*)" and "Dispositivo lóxico" ([^\"]*):([^\"]*)$/ then
      formato = Formato.find_by_nome($1)
      dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical($2,$3)
      subformato = Subformato.find_by_formato_id_and_dispositivoloxico_id(formato.id,dispositivoloxico.id)
      subformato_path(subformato)

    #edit
    when /^page for edit a "Dispositivo lóxico" ([^\"]*):([^\"]*)$/ then
      id = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical($1,$2)
		  edit_dispositivoloxico_path(id)
    when /^page for edit "Formato" called "([^\"]*)"$/ then
      id = Formato.find_by_nome($1)
      edit_formato_path(id)
    when /^page for edit "Estilo" called "([^\"]*)"$/ then
      estilo = Estilo.find_by_nome($1)
      edit_estilo_path(estilo)
    when /^page for edit "Diapositiva" called "([^\"]*)"$/ then
      diapositiva = Diapositiva.find_by_nome($1)
      edit_diapositiva_path(diapositiva)
    when /^page for edit "Lista de reprodución" called "([^\"]*)"$/ then
      lista = Listareproducion.find_by_nome($1)
      edit_listareproducion_path(lista)
    when /^page for edit "Dispositivo físico" called "([^\"]*)"$/ then
      dispositivo = Dispositivofisico.find_by_nome($1)
      edit_dispositivofisico_path(dispositivo)
    when /^page for edit "Parámetro de configuración" called "([^\"]*)"$/ then
      parametro = Parametro.find_by_nome($1)
      edit_parametro_path(parametro)
    when /^page for edit "Diapositiva" called "([^\"]*)" in "Lista de reprodución" called "([^\"]*)"$/ then
      diapositiva = Diapositiva.find_by_nome($1)
      listareproducion = Listareproducion.find_by_nome($2)
      rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id(diapositiva.id,listareproducion.id)
      '/diapositivas_listareproducions/' + rexistro.id.to_s + '/edit'

    when /^diapositiva called "([^\"]*)"$/
      diapositiva = Diapositiva.find_by_nome($1)
      '/contidos/' + diapositiva.id.to_s

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
