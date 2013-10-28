# encoding: utf-8

Feature: 12. Creación de subformatos para un formato
Como usuario da aplicación
Quero poder engadir subformatos a un formato
Para poder amplicar as adaptacións dun formato a novos dispositivos

Background: datos almacenados na base de datos

Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Scenario: Creación de subformatos para un formato
    Given I am on the home page
    When I follow "Formatos"
    Then I should be on "Formatos" page
    When I follow "Editar"
    Then I should be on page for edit "Formato" called "Formato Un"
    When I check "dispositivo_"
    And I press "Crear Subformatos"
    Then "Formato" called "Formato Un" has a "Subformato"