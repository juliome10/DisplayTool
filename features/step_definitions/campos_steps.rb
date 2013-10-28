# encoding: utf-8

Given /^the following campos exist:$/ do |campos_table|
	campos_table.hashes.each do |campo|
		Campo.create!(campo)
	end
	campos_table.hashes.size == Campo.all.count
end

#Then /^I can select any campo which type is ([^"]*)$/ do |tipo|
#  @filtradoCampos = Campo.find_all_by_tipo(tipo)
#  assert @filtradoCampos.length > 0
#end

Then /^I can select any campo which type is ([^"]*)?$/ do |tipo|
    subtipo = nil
    if tipo == 'Vídeo local'
      tipo = 'Vídeo'
      subtipo = 'Local'
    elsif tipo == 'Vídeo embebido'
      tipo = 'Vídeo'
      subtipo = 'Embebido'
    end
    if !subtipo.nil?
      @filtradoCampos = Campo.find_all_by_tipo_and_subtipo(tipo,subtipo)
    else
      @filtradoCampos = Campo.find_all_by_tipo(tipo)
    end
  
  assert @filtradoCampos.length > 0
end