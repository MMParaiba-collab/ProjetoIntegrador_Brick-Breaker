 # Regras, Áudio e Mecânicas de Jogo (Game Mechanics)

Este documento descreve as mecânicas de jogo, regras de pontuação, gerenciamento de áudio e fluxo de jogo do aplicativo ``Brick Breaker``, desenvolvido para a disciplina de Projeto Integrador VI-A.


 ## 1. Controles e Usabilidade.

* Controle do Paddle (Raquete): O jogador movimenta a plataforma na parte inferior da tela através de arrasto (drag/touch) para rebater a bola.
* Ocupação da Tela: O aplicativo é projetado para utilizar a maior área útil possível do dispositivo móvel, adaptando a escala do jogo dinamicamente.

## 2. Efeitos Sonoros e Áudio.

Conforme os requisitos da disciplina, o jogo conta com feedback sonoro para eventos chave:
* Início da Fase: Emissão de efeito sonoro de inicialização ao carregar cada um dos 5 níveis.
* Impacto no Paddle: Emissão de efeito sonoro característico sempre que a bola colide com a plataforma móvel.


## 3. Sistema de Vidas e Replay.

* O jogador inicia cada nível com 3 vidas.
* Se a bola passar do paddle e atingir a borda inferior da tela:

  * Uma vida é descomputada.
  * Se todas as vidas forem perdidas, é exibida a tela de **Game Over.
  * Game Over:
  * O jogador pode escolher entre Reiniciar o Nível Atual ou **Avançar para o Próximo Nível.

## 4. Regras de Vitória e Avanço de Fases

* Transição Automática:** Ao destruir todos os blocos do nível atual, o jogo avança automaticamente para a próxima fase.
* Condição de Vitória Total:** Ao concluir o Nível 5 (Fortaleza), o jogador é direcionado para a Tela de Vitória, exibindo o resumo de desempenho em todas as fases.
