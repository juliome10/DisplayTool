# encoding: utf-8

Feature: 4. Creación dun formato
Como usuario da aplicación
Quero poder crear un formato,
Para poder contar con unha nova posibilidade de deseño

Scenario: Creación dun formato.
        Given I am on the home page
	When I follow "Formatos"
	Then I should be on "Formatos" page
	When I follow "Engadir un novo formato"
      	Then I should be on page for create a new "Formato"
	When I fill in "nome" with "Formato Novo"
	And I fill in "descricion" with "Este é un novo formato."
	And I press "Crear formato"
      	Then I should be on page for view details from "Formato" called "Formato Novo"