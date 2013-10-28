# encoding: utf-8

Feature: 18. Modificación dos valores dos campos dun estilo
Como usuario da aplicación
Quero poder modificar os valores que terá cada tipo de campo
Para que cada un destos cumpra as novas necesidades

Background: datos almacenados na base de datos

Given the following estilos exist:
| nome      |
| Estilo Un |

Given the following campos exist:
| tipo  | subtipo    |
| Texto | Título     |

Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |
| Aliñado vertical do título       | titulo_alinadoVertical       | Centro        |
| Cor da fonte do título           | titulo_cor                   | #ffffff       |
| Fonte do título                  | titulo_fonte                 | Comic Sans MS |
| Tamaño da fonte do título        | titulo_tamano                | 40px          |

Scenario: Modificación dos valores dos campos dun estilo
    Given estilo called "Estilo Un" has default values for "Título" campo
    Given I am on the home page
    When I follow "Estilos"
    Then I should be on "Estilos" page
    When I follow "Editar"
    Then I should be on page for edit "Estilo" called "Estilo Un"
    When I select "Verdana" from "fontes_"
    And I fill in "cores_" with "#fefefe"
    And I fill in "tamanos_" with "100px"
    And I select "Dereita" from "alinadosH_"
    And I select "Abaixo" from "alinadosV_"
    And I press the third "Actualizar datos" button
    Then I should be on page for view details from "Estilo" called "Estilo Un"
    And estilo called "Estilo Un" has "Verdana" as "fonte" for "Título"
    And estilo called "Estilo Un" has "#fefefe" as "cor" for "Título"
    And estilo called "Estilo Un" has "100px" as "tamaño" for "Título"
    And estilo called "Estilo Un" has "Dereita" as "aliñado horizontal" for "Título"
    And estilo called "Estilo Un" has "Abaixo" as "aliñado vertical" for "Título"