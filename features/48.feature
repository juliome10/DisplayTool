# encoding: utf-8
Feature: 48. Eliminación dun dispositivo físico
Como usuario da aplicación
Quero poder eliminar un dispositivo
Para poder desvinculalo da aplicación

Background: datos almacenados na base de datos
Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Given the following dispositivofisicos exist:
| nome                  |
| Dispositivo Físico Un |

Scenario: Eliminación dun dispositivo físico.
    Given dispositivo físico called "Dispositivo Físico Un" belongs to dispositivo lóxico 16:9
    Given I am on the home page
    When I follow "Dispositivos físicos"
    Then I should be on "Dispositivos físicos" page
    When I follow "Eliminar"
    Then I should be on "Dispositivos físicos" page
    And there is a notification
    And there is no dispositivos físicos