# encoding: utf-8

Given /^the following estilos exist:$/ do |estilos_table|
	estilos_table.hashes.each do |estilo|
		Estilo.create!(estilo)
	end
	estilos_table.hashes.size == Estilo.all.count
end

Given /^estilo called "([^"]*)" has default values for "([^"]*)" campo$/ do |nome,tipoCampo|
  estilo = Estilo.find_by_nome(nome)
  campo = Campo.find_by_subtipo(tipoCampo)
    #Inicialízase cos valores por defecto (parámetros de configuración)
    if tipoCampo == 'Título'
      CamposEstilo.create!(:campo_id => campo.id, :estilo_id => estilo.id, :fonte => Parametro.find_by_variable('titulo_fonte').valor, :tamano => Parametro.find_by_variable('titulo_tamano').valor, :cor => Parametro.find_by_variable('titulo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('titulo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('titulo_alinadoVertical').valor)
  elsif tipoCampo == 'Subtítulo'
      CamposEstilo.create!(:campo_id => campo.id, :estilo_id => estilo.id, :fonte => Parametro.find_by_variable('subtitulo_fonte').valor, :tamano => Parametro.find_by_variable('subtitulo_tamano').valor, :cor => Parametro.find_by_variable('subtitulo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('subtitulo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('subtitulo_alinadoVertical').valor)
  elsif tipoCampo == 'Resumo'
      CamposEstilo.create!(:campo_id => campo.id, :estilo_id => estilo.id, :fonte => Parametro.find_by_variable('resumo_fonte').valor, :tamano => Parametro.find_by_variable('resumo_tamano').valor, :cor => Parametro.find_by_variable('resumo_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('resumo_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('resumo_alinadoVertical').valor)
  elsif tipoCampo == 'Descrición'
      CamposEstilo.create!(:campo_id => campo.id, :estilo_id => estilo.id, :fonte => Parametro.find_by_variable('descricion_fonte').valor, :tamano => Parametro.find_by_variable('descricion_tamano').valor, :cor => Parametro.find_by_variable('descricion_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('descricion_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('descricion_alinadoVertical').valor)
  elsif tipoCampo == 'Pé'
      CamposEstilo.create!(:campo_id => campo.id, :estilo_id => estilo.id, :fonte => Parametro.find_by_variable('pe_fonte').valor, :tamano => Parametro.find_by_variable('pe_tamano').valor, :cor => Parametro.find_by_variable('pe_cor').valor, :alinadoHorizontal => Parametro.find_by_variable('pe_alinadoHorizontal').valor, :alinadoVertical => Parametro.find_by_variable('pe_alinadoVertical').valor)
    else
      puts "Error, non existe dito tipo de campo!"
  end
end

Then /^estilo called "([^"]*)" has "([^"]*)" as background image$/ do |nome,valor|
  @estilo = Estilo.find_by_nome(nome)
  assert @estilo.background_image == valor
end

Then /^estilo called "([^"]*)" has "([^"]*)" as "([^"]*)" for "([^"]*)"$/ do |nome,valor,propiedade,campo|
  @estilo = Estilo.find_by_nome(nome)
  @campo = Campo.find_by_subtipo(campo)
  @rexistro = CamposEstilo.find_by_campo_id_and_estilo_id(@campo.id,@estilo.id)
  
  if propiedade == 'fonte'
    assert @rexistro.fonte == valor
  elsif propiedade == 'cor'
    assert @rexistro.cor == valor
  elsif propiedade == 'tamaño'
    assert @rexistro.tamano == valor
  elsif propiedade == 'aliñado horizontal'
    assert @rexistro.alinadoHorizontal == valor
  elsif propiedade == 'aliñado vertical'
    assert @rexistro.alinadoVertical == valor
  end
end

Then /^there is no estilos$/ do
    @estilos = Estilo.all
    assert @estilos.length == 0
  end

Then /^"Estilo" called "(.*?)" should be chosen$/ do |nome|
  @estilo = Estilo.find_by_nome(nome)
  @radio = 'estilo__' + @estilo.id.to_s
  field_checked = find_field(@radio)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
end