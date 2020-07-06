# Anotações de Desenvolvimento

O teste consiste em desenvolver a tela Fundamentos do app Lojong. Como se trata de uma tela gameficada, optei por usar SpriteKit pois embora seja possível fazer o mesmo no UIKit, o SpriteKit fornece otimizações e outras ferramentas necessárias, como TileMap, actions e camera por exemplo. Também fiz um fluxo simples entre telas, pois cada botão da rota leva a outra tela.

## Cenário
Quanto ao cenário, decidi fazer manualmente usando TileMap para ficar o mais semelhante possível ao fornecido no Figma. Outra ideia seria fazer o cenário proceduralmente, recebendo os dados do cenário, mas para essa tela, fazer manualmente era mais simples e mais rápido.

## Interação com Cenário
Utilizei SKSpriteNodes como botões em cima de onde estão os sprites de botão no TileMap, para facilitar a interação e evitar checagens desnecessárias, como saber qual tile do tilemap esta sendo clicado ao detectar toque na tela.

## Movimentação do Elefante

Coloquei manualmente os pontos para onde o Elefante vai ao ser liberado mais um dia.
