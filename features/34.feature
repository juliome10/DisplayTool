# encoding: utf-8

Feature: 34. Menú visible na interface
Como usuario da aplicación
Quero ter un menú de opcións sempre visible
Para unha navegación máis cómoda pola aplicación

Scenario: Menú visible na interface
    Given I am on the home page
    Then there is a menu
    Given I am on "Dispositivos lóxicos" page
    Then there is a menu
    Given I am on "Dispositivos físicos" page
    Then there is a menu
    Given I am on "Formatos" page
    Then there is a menu
    Given I am on "Diapositivas" page
    Then there is a menu
    Given I am on "Listas de reprodución" page
    Then there is a menu
    Given I am on "Estilos" page
    Then there is a menu
    Given I am on "Arquivos" page
    Then there is a menu
    Given I am on "Parámetros de configuración" page
    Then there is a menu
