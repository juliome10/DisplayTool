# encoding: utf-8
Feature: 45. Asignar lista de reprodución a dispositivo físico
Como usuario da aplicación
Quero poder asignar unha lista de reprodución a un dispositivo
Para poder visualizar os seus contidos no mesmo

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

Given the following diapositivas exist:
| nome           |
| Diapositiva Un |

Given the following listareproducions exist:
| id | nome     |
| 1  | Lista Un |

Given the following dispositivofisicos exist:
| nome                  |
| Dispositivo Físico Un |

Scenario: Asignar lista de reprodución a dispositivo físico.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given "Lista de reprodución" called "Lista Un" has "Diapositiva" called "Diapositiva Un"
    Given dispositivo físico called "Dispositivo Físico Un" belongs to dispositivo lóxico 16:9
    Given I am on the home page
    When I follow "Dispositivos físicos"
    Then I should be on "Dispositivos físicos" page
    When I follow "Editar"
    Then I should be on page for edit "Dispositivo físico" called "Dispositivo Físico Un"
    When I select "1" from "listareproducion"
    And I press "Asignar lista"
    Then I should be on "Dispositivos físicos" page
    And there is a notification
    And "Dispositivo Físico" called "Dispositivo Físico Un" belongs to "Lista de reprodución" called "Lista Un"