# encoding: utf-8

Feature: 3. Eliminación dun dispositivo lóxico
Como usuario da aplicación
Quero poder eliminar un dispositivo lóxico
Para poder desvinculalo cando non sexa necesario

Background: Dispositivos lóxicos na base de datos.

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Scenario: Eliminación dun dispositivo lóxico.
        Given I am on the home page
	When I follow "Dispositivos lóxicos"
	Then I should be on "Dispositivos lóxicos" page
	When I follow "Eliminar"
      	Then I should be on "Dispositivos lóxicos" page
        And I should not have dispositivos lóxicos
        And there is a notification