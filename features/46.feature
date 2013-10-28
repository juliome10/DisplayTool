# encoding: utf-8
Feature: 46. Modificación da lista de reprodución dun dispositivo
Como usuario da aplicación
Quero poder modificar a asignación dunha lista de reprodución a un dispositivo
Para poder visualizar outros contidos no mesmo

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
| id | nome       |
| 1  | Lista Un   |
| 2  | Lista Dous |

Given the following dispositivofisicos exist:
| nome                  |
| Dispositivo Físico Un |

Scenario: Modificación da lista de reprodución dun dispositivo.
    Given "Formato" called "Formato Un" has "Título"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "Título de proba" as "Título"
    Given "Lista de reprodución" called "Lista Un" has "Diapositiva" called "Diapositiva Un"
    Given "Lista de reprodución" called "Lista Dous" has "Diapositiva" called "Diapositiva Un"
    Given dispositivo físico called "Dispositivo Físico Un" belongs to dispositivo lóxico 16:9
    Given "Dispositivo físico" called "Dispositivo Físico Un" has "Lista de reprodución" called "Lista Un"
    Given I am on the home page
    When I follow "Dispositivos físicos"
    Then I should be on "Dispositivos físicos" page
    When I follow "Editar"
    Then I should be on page for edit "Dispositivo físico" called "Dispositivo Físico Un"
    And "Dispositivo físico" called "Dispositivo Físico Un" belongs to "Lista de reprodución" which id is 1
    When I select "2" from "listareproducion"
    And I press "Asignar lista"
    Then I should be on "Dispositivos físicos" page
    And there is a notification
    And "Dispositivo Físico" called "Dispositivo Físico Un" belongs to "Lista de reprodución" called "Lista Dous"