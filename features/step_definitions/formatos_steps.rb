# encoding: utf-8

Given /^the following formatos exist:$/ do |formatos_table|
	formatos_table.hashes.each do |formato|
		Formato.create!(formato)
	end
	formatos_table.hashes.size == Formato.all.count
end

Given /^"Formato" called "([^"]*)" has "([^"]*)"$/ do |nome, campo|
   @formato = Formato.find_by_nome(nome)
   @campo = Campo.find_by_subtipo(campo)
   @formato.campos << @campo
end

 Given /^"Formato" called "([^"]*)" has "Subformato" for "Dispositivo" ([^"]*):([^"]*)$/ do |nome,rah,rav|
   @formato = Formato.find_by_nome(nome)
   @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(rah,rav)
   @subformato = Subformato.create!(:dispositivoloxico_id => @dispositivoloxico.id, :formato_id => @formato.id)

   @formato.campos.each do |campo|
    @rexistro = CamposFormato.find_by_campo_id_and_formato_id(campo.id,@formato.id)
    CamposFormatosSubformato.create!(:subformato_id => @subformato.id, :campos_formatos_formato_id => @formato.id, :campos_formatos_campo_id => campo.id, :campos_formato_id => @rexistro.id)
   end
 end

 Then /^"Formato" called "([^"]*)" has a "Campo"$/ do |nome|
  @formato = Formato.find_by_nome(nome)
  assert @formato.campos.length > 0
 end
 
  Then /^"Formato" called "([^"]*)" has no "Campo"$/ do |nome|
    @formato = Formato.find_by_nome(nome)
    assert @formato.campos.length == 0
  end

  Then /^"Formato" called "([^"]*)" has a "Subformato"$/ do |nome|
    @formato = Formato.find_by_nome(nome)
    assert @formato.subformatos.length > 0
  end

  Then /^there is no "Formato"$/ do
    @formatos = Formato.all
    assert @formatos.length == 0
  end