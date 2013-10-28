# encoding: utf-8

Feature: 7. Campos de imaxe
Como usuario da aplicación
Quero poder expoñer imaxes
Para poder amosar calquera contido de tipo imaxe

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


Scenario: Campos de imaxe.
Then I can select any campo which type is Imaxe