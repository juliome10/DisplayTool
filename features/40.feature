# encoding: utf-8

Feature: 40. Galería multimedia
Como usuario da aplicación
Quero poder consultar os contidos multimedia aloxados no servidor
Para dispoñer dun catálogo destos

Scenario: Galería multimedia.
    Given I am on the home page
    When I follow "Arquivos"
    Then I should be on "Arquivos" page