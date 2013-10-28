# encoding: utf-8

Feature: 32. Eliminación dunha lista de reprodución
Como usuario da aplicación
Quero poder eliminar unha lista de reprodución
Para desvinculala cando deixe de ser necesaria

Background: datos almacenados na lista de reprodución
Given the following listareproducions exist:
| nome     |
| Lista Un |

Scenario: Eliminación dunha lista de reprodución.
    Given I am on the home page
    When I follow "Listas de reprodución"
    Then I should be on "Listas de reprodución" page
    When I follow "Eliminar"
    Then I should be on "Listas de reprodución" page
    And there is a notification
    And there is no listas de reprodución