# encoding: utf-8

Feature: 11. Eliminación de campos dun formato
Como usuario da aplicación
Quero poder eliminar campos dun formato
Para poder prescindir de contidos que o forman

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

Scenario: Eliminación de campos dun formato.
    Given "Formato" called "Formato Un" has "Título"
    Given I am on the home page
    When I follow "Formatos"
    Then I should be on "Formatos" page
    When I follow "Editar"
    Then I should be on page for edit "Formato" called "Formato Un"
    When I follow "Xestionar campos"
    Then I should be on "Campos" page for "Formato" called "Formato Un"
    When I press "Eliminar"
    Then "Formato" called "Formato Un" has no "Campo"