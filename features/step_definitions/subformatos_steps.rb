# encoding: utf-8

Then /^a preview panel exists$/ do
   panel = first('#canvas')
   assert !panel.nil?
 end
