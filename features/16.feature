# encoding: utf-8

Feature: 16. Creación dun estilo
Como usuario da aplicación
Quero poder crear un estilo
Para poder definir unha apariencia para as diapositivas

Background: datos almacenados na base de datos

Given the following campos exist:
| tipo  | subtipo    |
| Texto | Título     |
| Texto | Subtítulo  |

Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do subtítulo  | subtitulo_alinadoHorizontal  | Centrado      |
| Aliñado vertical do subtítulo    | subtitulo_alinadoVertical    | Centro        |
| Cor da fonte do subtítulo        | subtitulo_cor                | #ffffff       |
| Fonte do subtítulo               | subtitulo_fonte              | Comic Sans MS |
| Tamaño da fonte do subtítulo     | subtitulo_tamano             | 25px          |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |
| Aliñado vertical do título       | titulo_alinadoVertical       | Centro        |
| Cor da fonte do título           | titulo_cor                   | #ffffff       |
| Fonte do título                  | titulo_fonte                 | Comic Sans MS |
| Tamaño da fonte do título        | titulo_tamano                | 40px          |

Scenario: Creación dun estilo
    Given I am on the home page
    When I follow "Estilos"
    Then I should be on "Estilos" page
    When I follow "Engadir estilo"
    Then I should be on page for create a new "Estilo"
    When I fill in "nome" with "Novo estilo"
    And I fill in "descricion" with "Novo estilo para probas"
    And I fill in "background_color" with "#123456"
    And I press "Crear estilo"
    Then I should be on page for edit "Estilo" called "Novo estilo"