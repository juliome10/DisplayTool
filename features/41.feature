# encoding: utf-8

Feature: 41. Escoller contidos da galería
Como usuario da aplicación
Quero poder escoller contidos aloxados no servidor cando sexa necesario
Para poder empregalos cando sexa posible

Scenario: Escoller contidos da galería na creación dun estilo
    Given I am on the home page
    When I follow "Estilos"
    Then I should be on "Estilos" page
    When I follow "Engadir estilo"
    Then I should be on page for create a new "Estilo"
    When I click on "Escoller da galería"
    Then I should see a "Galería"