# encoding: utf-8

Feature: 15. Configuración dos campos dun subformato
Como usuario da aplicación
Quero poder configurar os campos dun subformato
Para poder configurar a visualización dos campos no tipo de dispositivo

Background: datos almacenados na base de datos

Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Given the following campos exist:
| tipo  | subtipo    |
| Texto | Título     |
| Texto | Subtítulo  |
| Texto | Resumo     |
| Texto | Descrición |
| Texto | Pé         |
| Imaxe | Logo       |
| Imaxe | Foto       |
| Vídeo | Local      |
| Vídeo | Embebido   |

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Scenario: Configuración dos campos dun subformato.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given I am on the home page
    When I follow "Formatos"
    Then I should be on "Formatos" page
    When I follow "Editar"
    Then I should be on page for edit "Formato" called "Formato Un"
    When I follow "Consultar"
    Then I should be on "Subformato" page which belongs to "Formato" called "Formato Un" and "Dispositivo lóxico" 16:9
    When I fill in "posicionX" with "5"
    And I fill in "posicionY" with "5"
    And I fill in "lonxitudeX" with "90"
    And I fill in "lonxitudeY" with "5"
    When I press "Actualizar"
    Then I should be on "Subformato" page which belongs to "Formato" called "Formato Un" and "Dispositivo lóxico" 16:9
    And there is a notification
    And a preview panel exists