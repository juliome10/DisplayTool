# encoding: utf-8

Feature: 24. Creación dunha lista de reprodución
Como usuario da aplicación
Quero poder crear unha lista de reprodución
Para poder amosar un conxunto de diapositivas de maneira automática

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
| id | nome           | estilo_id |
|  1 | Diapositiva Un |         1 |

Scenario: Creación dunha lista de reprodución.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given estilo called "Estilo Un" has default values for "Título" campo
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given I am on the home page
    When I follow "Listas de reprodución"
    Then I should be on "Listas de reprodución" page
    When I follow "Nova lista de reprodución"
    Then I should be on page for create a new "Lista de reprodución"
    When I choose dispositivo lóxico 16:9
    And I press "Selecionar"
    Then I should be on page for create a new Lista de reprodución with diapositivas for dispositivo 16:9
    When I fill in "nome" with "Lista Un"
    And I select "1" from "diapositiva"
    And I fill in "factorTempoDiapositiva" with "2"
    And I press "Engadir diapositiva"
    Then I should be on page for edit "Lista de reprodución" called "Lista Un"
    And there is a notification