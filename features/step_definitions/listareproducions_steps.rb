# encoding: utf-8

Given /^the following listareproducions exist:$/ do |listareproducions_table|
	listareproducions_table.hashes.each do |listareproducion|
		Listareproducion.create!(listareproducion)
	end
	listareproducions_table.hashes.size == Listareproducion.all.count
end

Given /^"Lista de reprodución" called "([^"]*)" has "Diapositiva" called "([^"]*)"$/ do |lista,diapositiva|
  @listareproducion = Listareproducion.find_by_nome(lista)
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @listareproducion.diapositivas << @diapositiva
  @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id)
  @rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id(@diapositiva.id,@listareproducion.id)
  @rexistro.update_attributes!(:orde => @rexistros.length)
end

Given /^"Lista de reprodución" called "([^"]*)" has "Diapositiva" called "([^"]*)" with "factor tempo" ([^"]*)$/ do |lista,diapositiva,ft|
  @listareproducion = Listareproducion.find_by_nome(lista)
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @listareproducion.diapositivas << @diapositiva
  @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id)
  @rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id(@diapositiva.id,@listareproducion.id)
  @rexistro.update_attributes!(:orde => @rexistros.length, :factorTempo => ft)
end

Given /^"Lista de reprodución" called "([^"]*)" has "Diapositiva" called "([^"]*)" with "order" ([^"]*)$/ do |lista,diapositiva,orde|
  @listareproducion = Listareproducion.find_by_nome(lista)
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @listareproducion.diapositivas << @diapositiva
  @rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id(@diapositiva.id,@listareproducion.id)
  @rexistro.update_attributes!(:orde => orde)
end

Then /^there is no listas de reprodución$/ do
  @listasreproducion = Listareproducion.all
  assert @listasreproducion.length == 0
end

Then /^the ([^"]*) "Diapositiva" in "Lista de reprodución" called "([^"]*)" is "([^"]*)"$/ do |orden,lista,diapositiva|
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @listareproducion = Listareproducion.find_by_nome(lista)
  @rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id_and_orde(@diapositiva.id,@listareproducion.id,orden)
  assert !@rexistro.nil?
end

Then /^the duration of "Diapositiva" called "([^"]*)" in "Lista de reprodución" called "([^"]*)" is ([^"]*)$/ do |diapositiva,lista,tempo|
  @diapositiva = Diapositiva.find_by_nome(diapositiva)
  @listareproducion = Listareproducion.find_by_nome(lista)
  @rexistro = DiapositivasListareproducion.find_by_diapositiva_id_and_listareproducion_id_and_factorTempo(@diapositiva.id,@listareproducion.id,tempo)
  assert !@rexistro.nil?
end

Then /^"Lista de reprodución" called "([^"]*)" has ([^"]*) diapositivas$/ do |lista,numero|
  @listareproducion = Listareproducion.find_by_nome(lista)
  @rexistros = DiapositivasListareproducion.find_all_by_listareproducion_id(@listareproducion.id)
  assert @rexistros.length == numero.to_i
end

When /^I click on arrow ([^"]*)$/ do |flecha|
  if flecha == 'down'
    arrow = first('#imaxeBaixar')
  elsif flecha == 'up'
    arrow = first('#imaxeSubir')
  end
  arrow.click
end