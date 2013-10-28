# encoding: utf-8

Feature: 2. Modificación dun dispositivo lóxico
Como usuario da aplicación
Quero poder modificar un dispositivo lóxico
Para poder corrixir os valores da relación de aspecto do mesmo

Background: Dispositivos lóxicos na base de datos.

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Scenario: Modificación dun dispositivo lóxico.
        Given I am on the home page
	When I follow "Dispositivos lóxicos"
        Then I should be on "Dispositivos lóxicos" page
	When I follow "Editar"
      	Then I should be on page for edit a "Dispositivo lóxico" 16:9
        Then the "relacionAspectoHorizontal" field should contain "16"
	And the "relacionAspectoVertical" field should contain "9"
        When I fill in "relacionAspectoHorizontal" with "2"
	And I fill in "relacionAspectoVertical" with "1"
	And I press "Gardar cambios"
      	Then I should be on page for view details from "Dispositivo lóxico" 2:1
