# encoding: utf-8

Feature: 19. Eliminación dun estilo
Como usuario da aplicación
Quero poder eliminar un estilo
Para poder desvinculalo cando non sexa necesario

Background: datos almacenados na base de datos
Given the following estilos exist:
| nome      |
| Estilo Un |

Scenario: Eliminación dun estilo.
    Given I am on the home page
    When I follow "Estilo"
    Then I should be on "Estilos" page
    When I follow "Eliminar"
    Then there is no estilos
    And there is a notification