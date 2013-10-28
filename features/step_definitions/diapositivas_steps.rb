# encoding: utf-8

Given /^the following diapositivas exist:$/ do |diapositivas_table|
	diapositivas_table.hashes.each do |diapositiva|
		Diapositiva.create!(diapositiva)
	end
	diapositivas_table.hashes.size == Diapositiva.all.count
end

Given /^"Diapositiva" called "([^"]*)" belongs to "Formato" called "([^"]*)" and has "([^"]*)" as "([^"]*)"$/ do |diapositiva,formato,valor,campo|
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @campo = Campo.find_by_subtipo(campo)
  @formato = Formato.find_by_nome(formato)
  @rexistro = CamposFormatosSubformato.find_by_campos_formatos_campo_id_and_campos_formatos_formato_id(@campo.id,@formato.id)
  CamposFormatosSubformatosDiapositiva.create!(:campos_formatos_subformatos_campos_formatos_formato_id => @formato.id, :campos_formatos_subformatos_campos_formatos_campo_id => @campo.id, :campos_formatos_subformatos_subformato_id => @rexistro.subformato_id, :diapositiva_id => @diapositiva.id, :contido => valor, :campos_formatos_subformato_id => @rexistro.id)
end

Then /^"Diapositiva" called "([^"]*)" has "([^"]*)" as "([^"]*)"$/ do |diapositiva,valor,campo|
  @campo = Campo.find_by_subtipo(campo)
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @rexistro = CamposFormatosSubformatosDiapositiva.find_by_contido_and_diapositiva_id_and_campos_formatos_subformatos_campos_formatos_campo_id(valor,@diapositiva.id,@campo.id)
  assert !@rexistro.nil?
end

Then /^"Diapositiva" called "([^"]*)" belongs to "Estilo" called "([^"]*)"$/ do  |diapositiva, estilo|
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @estilo = Estilo.find_by_nome(estilo)
  assert @diapositiva.estilo_id == @estilo.id
end

 Then /^there is no diapositivas$/ do
    @diapositivas = Diapositiva.all
    assert @diapositivas.length == 0
 end

 Then /^video has autoplay property$/ do
    video = find('#video')
    html = video.native
    html2 = html.to_s
    assert html2.include? "autoplay"
 end

 Then /^redirection will be when video finish$/ do
  video = find('#video')
  page.has_xpath?("//meta[@http-equiv=\"refresh\" and contains(@content, \"video.duration;url=http://localhost:3000/public/listas/4/6.html}\")]")
 end