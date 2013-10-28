# encoding: utf-8
Feature: 43. Rexistro dun dispositivo físico
Como usuario da aplicación
Quero poder dar de alta un novo medio de visualización
Para poder contar con el na aplicación

Background: datos almacenados na base de datos

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |
|4                        |3                      |
|3                        |4                      |

Scenario: Rexistro dun dispositivo físico.
        Given I am on the home page
	When I follow "Dispositivos físicos"
	Then I should be on "Dispositivos físicos" page
	When I follow "Engadir un novo dispositivo"
      	Then I should be on page for create a new "Dispositivo físico"
	When I fill in "nome" with "dispositivo1"
	And I fill in "descricion" with "Dispositivo de proba"
        And I fill in "situacion" with "Hall do edificio"
        And I select "4:3" from "dispositivoLoxico"
	And I press "Gardar dispositivo"
      	Then I should be on "Dispositivos físicos" page
        And there is a notification