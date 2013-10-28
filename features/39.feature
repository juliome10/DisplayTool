# encoding: utf-8

Feature: 39. Modificar valores dos parámetros de configuración
Como usuario da aplicación
Quero poder modificar o valor dos parámetros de configuración
Para actualizar o valor cando sexa necesario

Background: datos almacenados na base de datos
Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |

Scenario: Modificar valores dos parámetros de configuración.
    Given I am on the home page
    When I follow "Parámetros de configuración"
    Then I should be on "Parámetros de configuración" page
    When I follow "Editar"
    Then I should be on page for edit "Parámetro de configuración" called "Aliñado horizontal do título"
    And "Centrado" should be selected for "valor"
    When I select "Esquerda" from "valor"
    And I press "Actualizar"
    Then I should be on "Parámetros de configuración" page
    And there is a notification
    And "Parámetro de configuración" called "Aliñado horizontal do título" has "Esquerda" as valor