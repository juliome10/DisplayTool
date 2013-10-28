# encoding: utf-8

Feature: 38. Parámetros de configuración
Como usuario da aplicación
Quero que existan valores predefinidos para certas propiedades
Para non ter que definilas do mesmo xeito repetidas veces

Background: datos almacenados na base de datos
Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |
| Aliñado vertical do título       | titulo_alinadoVertical       | Centro        |
| Cor da fonte do título           | titulo_cor                   | #ffffff       |
| Fonte do título                  | titulo_fonte                 | Comic Sans MS |
| Tamaño da fonte do título        | titulo_tamano                | 40px          |

Scenario: Parámetros de configuración
    Given I am on the home page
    When I follow "Parámetros de configuración"
    Then I should be on "Parámetros de configuración" page