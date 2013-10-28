# encoding: utf-8

Given /^the following dispositivofisicos exist:$/ do |dispositivofisicos_table|
	dispositivofisicos_table.hashes.each do |dispositivofisico|
		Dispositivofisico.create!(dispositivofisico)
	end
	dispositivofisicos_table.hashes.size == Dispositivofisico.all.count
end

Given /^dispositivo físico called "([^"]*)" belongs to dispositivo lóxico ([^"]*):([^"]*)$/ do |nome,rah,rav|
  @dispositivofisico = Dispositivofisico.find_by_nome(nome)
  @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(rah,rav)
  @dispositivofisico.update_attributes!(:dispositivoloxico_id => @dispositivoloxico.id)
end

Given /^"Dispositivo físico" called "([^"]*)" has "Lista de reprodución" called "([^"]*)"$/ do |dispositivo,lista|
  @dispositivofisico = Dispositivofisico.find_by_nome(dispositivo)
  @listareproducion = Listareproducion.find_by_nome(lista)
  @dispositivofisico.update_attributes!(:listareproducion_id => @listareproducion.id)
end


Then /^I should not have dispositivos lóxicos$/ do
  @dispositivofisicos = Dispositivofisico.all
  assert @dispositivofisicos.length == 0
end

Then /^"Dispositivo físico" called "([^"]*)" has "([^"]*)" as descricion$/ do |nome,valor|
  @dispositivofisico = Dispositivofisico.find_by_nome(nome)
  assert @dispositivofisico.descricion == valor
end

Then /^"Dispositivo físico" called "([^"]*)" has "([^"]*)" as situacion$/ do |nome,valor|
  @dispositivofisico = Dispositivofisico.find_by_nome(nome)
  assert @dispositivofisico.situacion == valor
end

Then /^"Dispositivo físico" called "([^"]*)" belongs to dispositivo lóxico ([^"]*):([^"]*)$/ do |nome,rah,rav|
  @dispositivofisico = Dispositivofisico.find_by_nome(nome)
  @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(rah,rav)
  assert @dispositivofisico.dispositivoloxico.id == @dispositivoloxico.id
end

Then /^there is no dispositivos físicos$/ do
  @dispositivosfisicos = Dispositivofisico.all
  assert @dispositivosfisicos.length == 0
end

Then /^"Dispositivo Físico" called "([^"]*)" belongs to "Lista de reprodución" called "([^"]*)"$/ do |dispositivo,lista|
  @dispositivofisico = Dispositivofisico.find_by_nome(dispositivo)
  @listareproducion = Listareproducion.find_by_nome(lista)
  assert @dispositivofisico.listareproducion.id == @listareproducion.id
end

Then /^"Dispositivo físico" called "([^"]*)" belongs to "Lista de reprodución" which id is ([^"]*)$/ do |dispositivo,idLista|
  @dispositivofisico = Dispositivofisico.find_by_nome(dispositivo)
  assert @dispositivofisico.listareproducion.id == idLista.to_i
end

Then /^"Dispositivo físico" called "([^"]*)" has no lista de reprodución$/ do |dispositivo|
  @dispositivofisico = Dispositivofisico.find_by_nome(dispositivo)
  assert @dispositivofisico.listareproducion.nil?
end