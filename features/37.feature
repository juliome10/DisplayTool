# encoding: utf-8

Feature: 37. Tempo de exposición nas diapositivas con vídeo
Como usuario da aplicación
Quero que as diapositivas con vídeos se expoñan o tempo que duren estos
Para que o vídeo non se corte ou que se siga amosando a diapositiva unha vez que rematou

Background: datos almacenados na base de datos.
Given the following formatos exist:
|nome         |descricion                       |
|Formato Un   |Formato cun título e unha imaxe. |

Given the following campos exist:
| tipo  | subtipo    |
| Vídeo | Local      |

Given the following dispositivoloxicos exist:
|relacionAspectoHorizontal|relacionAspectoVertical|
|16                       |9                      |

Given the following parametros exist:
| nome                             | variable                     | valor         |
| Aliñado horizontal do título     | titulo_alinadoHorizontal     | Centrado      |
| Aliñado vertical do título       | titulo_alinadoVertical       | Centro        |
| Cor da fonte do título           | titulo_cor                   | #ffffff       |
| Fonte do título                  | titulo_fonte                 | Comic Sans MS |
| Tamaño da fonte do título        | titulo_tamano                | 40px          |

Given the following estilos exist:
| id | nome      |
|  1 | Estilo Un |

Given the following diapositivas exist:
| id | nome             | estilo_id | url                    |
|  5 | Diapositiva Un   |         1 | public/contidos/5.html |

Scenario: Tempo de exposición nas diapositivas con vídeo
    Given "Formato" called "Formato Un" has "Local"
    Given "Formato" called "Formato Un" has "Subformato" for "Dispositivo" 16:9
    Given "Diapositiva" called "Diapositiva Un" belongs to "Formato" called "Formato Un" and has "trailer.webm" as "Local"
    Given I am on the home page
    When I follow "Diapositivas"
    Then I should be on "Diapositivas" page
    When I follow "public/contidos/5.html"
    Then I should be on diapositiva called "Diapositiva Un"
    And redirection will be when video finish