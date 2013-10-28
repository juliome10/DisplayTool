# encoding: utf-8

Feature: 14. Subida de ficheiros
Como usuario da aplicación
Quero poder subir un ficheiro
Para dispoñer de máis contios multimedia que amosar

Scenario: Subida de ficheiros.
    Given I am on the home page
    When I follow "Arquivos"
    Then I should be on "Uploads" page
    And a upload panel exists