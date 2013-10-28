# encoding: utf-8

Feature: 5. Modificación dun formato
Como usuario da aplicación
Quero poder modificar os datos dun formato
Para poder cambiar o nome e a descrición do mesmo

Background: formatos que estan na base de datos

Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Scenario: Modificación dun formato.
        Given I am on the home page
	When I follow "Formatos"
	Then I should be on "Formatos" page
	When I follow "Editar"
      	Then I should be on page for edit "Formato" called "Formato Un"
	Then the "nome" field should contain "Formato Un"
	And the "descricion" field should contain "Formato cun título e unha imaxe."
        When I fill in "nome" with "Nome modificado"
	And I fill in "descricion" with "Esta é a descrición modificada."
	And I press "Actualizar datos"
      	Then I should be on page for view details from "Formato" called "Nome modificado"