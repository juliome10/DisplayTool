# encoding: utf-8
Feature: 44. Modificación dos datos dun dispositivo físico
Como usuario da aplicación
Quero poder modificar os datos dun dispositivo
Para poder contar cos seus datos actualizados

Background: datos almacenados na base de datos

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |
|4                        |3                      |
|3                        |4                      |

Given the following dispositivofisicos exist:
| nome                  | descricion                | situacion |
| Dispositivo Físico Un | Descrición do dispositivo | Hall      |

Scenario: Modificación dos datos dun dispositivo físico.
    Given dispositivo físico called "Dispositivo Físico Un" belongs to dispositivo lóxico 16:9
    Given I am on the home page
    When I follow "Dispositivos físicos"
    Then I should be on "Dispositivos físicos" page
    When I follow "Editar"
    Then I should be on page for edit "Dispositivo físico" called "Dispositivo Físico Un"
    And the "nome" field should contain "Dispositivo Físico Un"
    And the "descricion" field should contain "Descrición do dispositivo"
    And the "situacion" field should contain "Hall"
    And "16:9" should be selected for "dispositivoLoxico"
    When I fill in "nome" with "Novo Nome Dispositivo"
    And I fill in "descricion" with "Nova Descrición"
    And I fill in "situacion" with "Cafetería"
    And I select "4:3" from "dispositivoLoxico"
    And I press "Gardar cambios"
    Then I should be on "Dispositivos físicos" page
    And there is a notification
    And "Dispositivo físico" called "Novo Nome Dispositivo" has "Nova Descrición" as descricion
    And "Dispositivo físico" called "Novo Nome Dispositivo" has "Cafetería" as situacion
    And "Dispositivo físico" called "Novo Nome Dispositivo" belongs to dispositivo lóxico 4:3