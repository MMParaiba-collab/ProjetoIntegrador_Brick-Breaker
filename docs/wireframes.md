# Wireframes e Design das Telas

## 1. Objetivo da Prototipação

Os wireframes foram desenvolvidos para representar a estrutura visual e o fluxo de navegação do aplicativo Brick Breaker, desenvolvido como parte do Projeto Integrador VI-A.

A prototipação tem como objetivo apresentar a organização das telas, os principais componentes da interface e a relação entre as diferentes etapas do aplicativo antes da implementação. Dessa forma, o wireframe permite visualizar o funcionamento esperado da aplicação e a sequência de navegação realizada pelo usuário.

O projeto foi estruturado considerando a utilização em dispositivos móveis, priorizando uma interface simples, objetiva e adequada à interação durante o jogo.

## 2. Visão Geral do Wireframe

O fluxo completo das telas está representado no arquivo `Wireframes.png`, disponível na raiz do repositório.

O wireframe apresenta a Tela Principal, as telas auxiliares de Integrantes e Configurações, os cinco níveis do jogo, a tela de Game Over e a tela de Vitória. As telas estão conectadas por indicações de fluxo que representam as possibilidades de navegação do usuário dentro do aplicativo.

A estrutura foi planejada para permitir o acesso às funcionalidades principais a partir da Tela Principal e, durante o jogo, possibilitar a progressão entre os níveis de forma sequencial.
## 3. Fluxo de Navegação

A navegação do aplicativo foi planejada a partir da Tela Principal, que funciona como ponto de entrada para as principais funcionalidades da aplicação.

A partir da Tela Principal, o usuário pode acessar a tela de Integrantes, acessar as Configurações ou iniciar o jogo. Ao selecionar a opção de iniciar o jogo, o usuário é direcionado para o Nível 1.

Durante a execução do jogo, os níveis são organizados de forma sequencial. Após a conclusão de cada fase, o aplicativo direciona o usuário automaticamente para o nível seguinte, seguindo a ordem:

**Nível 1 → Nível 2 → Nível 3 → Nível 4 → Nível 5**

Ao final do Nível 5, quando todos os blocos forem destruídos, o fluxo direciona o usuário para a tela de Vitória.

Caso o jogador perca todas as vidas durante o jogo, o fluxo direciona para a tela de Game Over. Nessa tela, o usuário pode reiniciar o nível atual ou avançar para o próximo nível.

A representação visual dessas relações está apresentada no arquivo `Wireframes.png`, por meio de setas que indicam as possibilidades de navegação entre as telas.
## 4. Descrição das Telas

### 4.1 Tela Principal

A Tela Principal funciona como ponto de entrada do aplicativo. Nela são apresentados o título do jogo, a identificação do Projeto Integrador VI-A e uma orientação básica para utilização da aplicação.

A tela possui três opções principais:

* **JOGAR:** inicia a execução do jogo e direciona o usuário para o Nível 1.
* **INTEGRANTES:** direciona para a tela que apresenta os integrantes do grupo.
* **CONFIGURAÇÕES:** direciona para as opções de personalização relacionadas às cores e aos tamanhos dos tijolos.

A organização da tela prioriza o acesso direto às principais funcionalidades do aplicativo.

### 4.2 Tela de Integrantes

A Tela de Integrantes apresenta a identificação dos membros da equipe responsáveis pelo desenvolvimento do projeto.

A tela possui uma listagem com o nome dos integrantes e suas respectivas atribuições no projeto. Também possui a opção **VOLTAR**, permitindo retornar à Tela Principal.

Essa tela atende à necessidade de apresentar os integrantes do grupo dentro da aplicação.

### 4.3 Tela de Configurações

A Tela de Configurações permite ao usuário definir características visuais que serão utilizadas posteriormente na construção da parede de tijolos.

São disponibilizadas duas opções principais de configuração:

* **Padrão de Cores dos Tijolos:** seleção entre as paletas disponíveis, como Neon, Fogo, Oceano e Clássico.
* **Tamanho dos Tijolos:** seleção entre os tamanhos Pequeno, Médio e Grande.

A tela também apresenta uma pré-visualização da disposição dos blocos de acordo com as opções selecionadas.

Ao finalizar as alterações, o usuário pode selecionar **SALVAR CONFIGURAÇÕES** para confirmar as escolhas ou **VOLTAR SEM SALVAR** para retornar à Tela Principal sem aplicar as alterações.


## 4.4 Nível 1

O Nível 1 representa a primeira fase do jogo e apresenta uma parede de tijolos organizada de forma regular.

A tela possui uma área superior destinada à identificação do nível e à indicação da quantidade de vidas disponíveis. Abaixo dessas informações encontra-se a parede de tijolos que deverá ser destruída pelo jogador.

Durante a partida, a bola se movimenta pela área de jogo e deve ser rebatida pelo paddle controlado pelo usuário. Na parte inferior da tela é apresentado o paddle, responsável por impedir que a bola saia da área de jogo.

O Nível 1 funciona como ponto inicial da sequência de fases e, após a destruição de todos os tijolos, o usuário é direcionado para o Nível 2.


## 4.5 Nível 2

O Nível 2 apresenta uma nova configuração da parede de tijolos, utilizando uma disposição diferente da apresentada no nível anterior.

A estrutura dos blocos possui um formato específico, aumentando a variação visual e a dificuldade da fase. A tela mantém os mesmos elementos principais de interação, incluindo a indicação do nível, vidas, bola e paddle.

Após a destruição de todos os blocos, o fluxo do aplicativo direciona o usuário automaticamente para o Nível 3.


## 4.6 Nível 3

O Nível 3 apresenta uma nova disposição dos tijolos, utilizando espaços entre os blocos para formar um padrão diferente.

A organização dos elementos mantém a estrutura principal das fases anteriores, permitindo que o usuário reconheça os componentes de interação e concentre-se no controle do paddle e na movimentação da bola.

Ao concluir a destruição dos blocos, o usuário avança para o Nível 4.


## 4.7 Nível 4

O Nível 4 apresenta uma configuração de blocos com formato diferenciado em relação às fases anteriores.

A disposição dos tijolos cria uma estrutura mais elaborada para a parede de blocos, mantendo os elementos necessários para a execução da partida, como bola, paddle, indicação do nível e quantidade de vidas.

Após a conclusão da fase, o fluxo direciona o usuário para o Nível 5.


## 4.8 Nível 5

O Nível 5 representa a última fase do jogo e apresenta uma configuração própria para a parede de tijolos.

A fase mantém os elementos de interação utilizados nos níveis anteriores, permitindo que o jogador controle o paddle para rebater a bola e destruir todos os blocos.

Quando todos os tijolos do Nível 5 são destruídos, o fluxo do aplicativo é direcionado para a Tela de Vitória.


## 4.9 Tela de Game Over

A Tela de Game Over é apresentada quando o jogador perde todas as vidas disponíveis durante a partida.

Nessa tela são disponibilizadas opções para que o usuário possa continuar sua experiência no jogo. O usuário pode escolher entre reiniciar o nível atual ou avançar para o próximo nível.

A opção de reiniciar permite retornar à fase em que ocorreu a perda das vidas. A opção de avançar permite seguir para o próximo nível do jogo.

A tela também mantém a possibilidade de retornar ao fluxo principal do aplicativo por meio das opções apresentadas no wireframe.


## 4.10 Tela de Vitória

A Tela de Vitória é apresentada após a conclusão do último nível do jogo.

Essa tela informa ao usuário que todos os níveis foram concluídos e apresenta a quantidade de estrelas obtidas na partida.

Também é disponibilizada a opção de retornar à Tela Principal, encerrando o fluxo da partida e permitindo que o usuário tenha acesso novamente às funcionalidades principais do aplicativo.


# 5. Considerações sobre o Wireframe

O wireframe foi elaborado com o objetivo de representar previamente a estrutura das telas e o fluxo de navegação do aplicativo antes da implementação.

A organização apresentada permite visualizar a relação entre a Tela Principal, as telas auxiliares, os níveis do jogo e as telas de encerramento da partida.

A utilização de cinco níveis diferentes permite representar as diferentes configurações da parede de tijolos previstas para o projeto. As telas também foram planejadas de forma a manter uma estrutura visual consistente durante a execução do jogo.

O arquivo `Wireframes.png`, disponível na raiz do repositório, apresenta visualmente o fluxo completo da aplicação e complementa a descrição apresentada neste documento.
