# encoding: utf-8
Feature: 42. Asignación dun estilo a unha diapositiva
Como usuario da aplicción
Quero poder asignar un estilo a unha diapositiva
Para poder ter control do aspecto visual da mesma

Background: datos almacenados na base de datos
Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Given the following campos exist:
| tipo  | subtipo    |
| Texto | Título     |

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |
| Aliñado vertical do título       | titulo_alinadoVertical       | Centro        |
| Cor da fonte do título           | titulo_cor                   | #ffffff       |
| Fonte do título                  | titulo_fonte                 | Comic Sans MS |
| Tamaño da fonte do título        | titulo_tamano                | 40px          |

Given the following estilos exist:
| id | nome        |
|  1 | Estilo Un   |

Given the following diapositivas exist:
| id | nome           |
|  1 | Diapositiva Un |

Scenario: Asignación dun estilo a unha diapositiva.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given estilo called "Estilo Un" has default values for "Título" campo
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given I am on the home page
    When I follow "Diapositivas"
    Then I should be on "Diapositivas" page
    When I follow "Editar"
    Then I should be on page for edit "Diapositiva" called "Diapositiva Un"
    When I choose estilo called "Estilo Un"
    And I press "Actualizar contido"
    Then I should be on "Diapositivas" page
    And there is a notification
    And "Diapositiva" called "Diapositiva Un" belongs to "Estilo" called "Estilo Un"