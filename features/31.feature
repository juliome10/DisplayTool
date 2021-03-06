# encoding: utf-8

Feature: 31. Modificación do factor tempo das diapositivas dunha lista de reprodución
Como usuario da aplicación
Quero poder cambiar o factor tempo das diapositivas dunha lista de reprodución
Para poder satisfacer as novas necesidades

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
| id | nome      |
|  1 | Estilo Un |

Given the following diapositivas exist:
| id | nome             | estilo_id |
|  1 | Diapositiva Un   |         1 |

Given the following listareproducions exist:
| id | nome     |
| 1  | Lista Un |

Scenario: Modificación do factor tempo das diapositivas dunha lista de reprodución.
Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given "Lista de reprodución" called "Lista Un" has "Diapositiva" called "Diapositiva Un" with "factor tempo" 2
    Given I am on the home page
    When I follow "Listas de reprodución"
    Then I should be on "Listas de reprodución" page
    When I follow "Editar"
    Then I should be on page for edit "Lista de reprodución" called "Lista Un"
    When I follow "Editar"
    Then I should be on page for edit "Diapositiva" called "Diapositiva Un" in "Lista de reprodución" called "Lista Un"
    And the "factorTempo" field should contain "2"
    When I fill in "factorTempo" with "8"
    And I press "Actualizar"
    Then I should be on page for edit "Lista de reprodución" called "Lista Un"
    And there is a notification
    And the duration of "Diapositiva" called "Diapositiva Un" in "Lista de reprodución" called "Lista Un" is 8