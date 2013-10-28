# encoding: utf-8

Then /^a upload panel exists$/ do
   panel = first('#subida')
   assert !panel.nil?
 end