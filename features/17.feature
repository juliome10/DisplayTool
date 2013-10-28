# encoding: utf-8

Feature: 17. Modificación do fondo dun estilo
Como usuario da aplicación
Quero poder modificar o fondo dun estilo
Para que este cumpla coas novas necesidades

Background: datos almacenados na base de datos

Given the following estilos exist:
| nome      | background_image |
| Estilo Un | proba.jpg        |

Scenario: Modificación do fondo dun estilo
    Given I am on the home page
    When I follow "Estilos"
    Then I should be on "Estilos" page
    When I follow "Editar"
    Then I should be on page for edit "Estilo" called "Estilo Un"
    And the "background_image" field should contain "proba.jpg"
    When I fill in "background_image" with "probaModificado.jpg"
    And I press the second "Actualizar datos" button
    Then I should be on page for view details from "Estilo" called "Estilo Un"
    And there is a notification
    And estilo called "Estilo Un" has "probaModificado.jpg" as background image