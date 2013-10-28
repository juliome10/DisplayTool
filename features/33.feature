# encoding: utf-8

Feature: 33. Previsualización dun subformato
Como usuario da aplicación
Quero poder visualizar a composición dun subformato
Para poder comprobar a apariencia dunha futura diapositiva creada con el

Background: datos almacenados na base de datos.

Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Given the following campos exist:
| tipo  | subtipo    |
| Texto | Título     |

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Scenario: Previsualización dun subformato.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given I am on the home page
    When I follow "Formatos"
    Then I should be on "Formatos" page
    When I follow "Amosar"
    Then I should be on page for view details from "Formato" called "Formato Un"
    When I follow "Consultar"
    Then I should be on "Subformato" page which belongs to "Formato" called "Formato Un" and "Dispositivo lóxico" 16:9
    And a preview panel exists