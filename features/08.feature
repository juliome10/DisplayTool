# encoding: utf-8

Feature: 8. Campos de vídeo almacenado no servidor
Como usuario da aplicación
Quero poder expoñer vídeos do servidor
Para poder amosar calquera do vídeos dos que dispoño

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


Scenario: Campos de vídeo almacenado no servidor.
Then I can select any campo which type is Vídeo local