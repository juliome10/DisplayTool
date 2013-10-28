# encoding: utf-8

Given /^the following dispositivoloxicos exist:$/ do |dispositivoloxicos_table|
	dispositivoloxicos_table.hashes.each do |dispositivoloxico|
		Dispositivoloxico.create!(dispositivoloxico)
	end
	dispositivoloxicos_table.hashes.size == Dispositivoloxico.all.count
end

Then /^I should not have dispositivos lóxicos$/ do
  @dispositivoloxicos = Dispositivoloxico.all
  assert @dispositivoloxicos.length == 0
end

When /^I choose dispositivo lóxico ([^"]*):([^"]*)$/ do |rah,rav|
  @dispositivoloxico = Dispositivoloxico.find_by_relacionAspectoHorizontal_and_relacionAspectoVertical(rah,rav)
  @radio = 'dispositivo_' + @dispositivoloxico.id.to_s
  choose(@radio)
end

Then /^I have one dispositivo$/ do
  @dispositivoloxico = Dispositivoloxico.all
  assert @dispositivoloxico.length == 1
end