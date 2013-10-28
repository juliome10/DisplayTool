# encoding: utf-8

Feature: 9. Campos de vídeo embebido
Como usuario da aplicación
Quero poder expoñer vídeos aloxados en outros servidores
Para poder amosar calquera vídeo aloxado na Internet

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


Scenario: Campos de vídeo embebido.
Then I can select any campo which type is Vídeo embebido