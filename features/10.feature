# encoding: utf-8

Feature: 10. Introdución de campos a un formato
Como usuario da aplicación
Quero poder engadir campos a un formato
Para poder dispoñer de máis contidos no formato

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

Scenario: Introdución de campos a un formato.
        Given I am on the home page
	When I follow "Formatos"
        Then I should be on "Formatos" page
        When I follow "Editar"
        Then I should be on page for edit "Formato" called "Formato Un"
        When I follow "Xestionar campos"
        Then I should be on "Campos" page for "Formato" called "Formato Un"
        When I press one of the "Engadir" button
        Then "Formato" called "Formato Un" has a "Campo"
