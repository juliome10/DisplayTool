# encoding: utf-8

Given /^the following parametros exist:$/ do |parametros_table|
	parametros_table.hashes.each do |parametro|
		Parametro.create!(parametro)
	end
	parametros_table.hashes.size == Parametro.all.count
end

Then /^"Parámetro de configuración" called "([^"]*)" has "([^"]*)" as valor$/ do |parametro,valor|
  @parametro = Parametro.find_by_nome(parametro)
  assert @parametro.valor == valor
end