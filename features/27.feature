# encoding: utf-8

Feature: 27. Modificación dunha lista de reprodución
Como usuario da aplicación
Quero poder modificar os datos dunha lista de reprodución
Para poder cambiar a súa descrición

Background: datos almacenados na base de datos

Given the following listareproducions exist:
| nome     |
| Lista Un |

Scenario: Modificación dunha lista de reprodución.
    Given I am on the home page
    When I follow "Listas de reprodución"
    Then I should be on "Listas de reprodución" page
    When I follow "Editar"
    Then I should be on page for edit "Lista de reprodución" called "Lista Un"
    And the "nome" field should contain "Lista Un"
    When I fill in "nome" with "Nova Lista Un"
    And I press "Actualizar datos"
    Then I should be on page for view details from "Lista de reprodución" called "Nova Lista Un"
    And there is a notification