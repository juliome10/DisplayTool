# encoding: utf-8

Feature: 6. Campos de texto
Como usuario da aplicación
Quero poder expoñer textos
Para poder amosar calquera contido de tipo texto

Background: Campos que existirán por defecto na base de datos.
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


Scenario: Campos de texto.
Then I can select any campo which type is Texto