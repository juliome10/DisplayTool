# encoding: utf-8

Feature: 25. Configuración da orde das diapositivas
Como usuario da aplicación
Quero poder fixar a orde das diapositivas nunha lista de reprodución
Para poder visualizar cada unha na posición correcta

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
|  2 | Diapositiva Dous |         1 |

Scenario: Configuración da orde das diapositivas. Na creación da lista especifícase a primeira, e as que se engadan introduciranse en posicións consecutivas.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given estilo called "Estilo Un" has default values for "Título" campo
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given "Diapositiva" called "Diapositiva Dous" belongs to "Formato" called "Formato Un" and has "Título de proba dous" as "Título"
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
    When I follow "Engadir diapositiva á lista"
    Then I should be on page for add "Diapositiva" to "Lista de reprodución" called "Lista Un"
    When I select "2" from "diapositiva"
    And I fill in "factorTempoDiapositiva" with "2"
    And I press "Engadir diapositiva"
    Then I should be on page for edit "Lista de reprodución" called "Lista Un"
    And the 1 "Diapositiva" in "Lista de reprodución" called "Lista Un" is "Diapositiva Un"
    And the 2 "Diapositiva" in "Lista de reprodución" called "Lista Un" is "Diapositiva Dous"