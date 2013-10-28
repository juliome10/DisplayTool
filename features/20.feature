# encoding: utf-8

Feature: 20. Creación dunha diapositiva
Como usuario da aplicación
Quero poder crear unha diapositiva
Para poder contar cun novo contido que expoñer

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
| nome      |
| Estilo Un |


Scenario: Creación dunha diapositiva.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given estilo called "Estilo Un" has default values for "Título" campo
    Given I am on the home page
    When I follow "Diapositivas"
    Then I should be on "Diapositivas" page
    When I follow "Nova diapositiva"
    Then I should be on page for create a new "Diapositiva"
    When I check "subformato_"
    And I press "Selecionar"
    Then I should be on page for create a new Diapositiva which belongs to "Formato" called "Formato Un"
    When I fill in "nome" with "Diapostiva Un"
    And I fill in "valor_" with "Titulo da diapositiva"
    And I choose estilo called "Estilo Un"
    And I press "Gardar contido"
    Then I should be on "Diapositivas" page
    And there is a notification