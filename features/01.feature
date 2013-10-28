# encoding: utf-8

Feature: 1. Rexistro dun dispositivo lóxico
Como usuario da aplicación
Quero poder rexistrar un dispositivo lóxico
Para poder ampliar o catálogo de dispositivos dispoñible

Scenario: Rexistro dun dispositivo lóxico.
        Given I am on the home page
	When I follow "Dispositivos lóxicos"
	Then I should be on "Dispositivos lóxicos" page
	When I follow "Engadir un novo dispositivo"
      	Then I should be on page for create a new "Dispositivo lóxico"
	When I fill in "relacionAspectoHorizontal" with "16"
	And I fill in "relacionAspectoVertical" with "9"
	And I press "Gardar dispositivo"
      	Then I should be on "Dispositivos lóxicos" page
        And there is a notification
	And I have one dispositivo
