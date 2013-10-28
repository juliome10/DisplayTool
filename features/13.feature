# encoding: utf-8

Feature: 13. Eliminación dun formato
Como usuario da aplicación
Quero poder eliminar un formato
Para poder desvinculalo cando non sexa necesario

Background: formatos que estan na base de datos

Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Scenario: Eliminación dun formato
        Given I am on the home page
        When I follow "Formatos"
      	Then I should be on "Formatos" page
      	When I follow "Eliminar"
      	Then I should be on "Formatos" page
	And there is no "Formato"
        And there is a notification
