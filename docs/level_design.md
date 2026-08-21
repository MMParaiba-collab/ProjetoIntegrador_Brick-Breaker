# Documentação e Arquitetura dos Níveis (Level Design)

Este documento descreve a metodologia, as estruturas de dados e os algoritmos empregados na construção e geração das paredes de tijolos (blocos) para o jogo **Brick Breaker**, desenvolvido para a disciplina de **Projeto Integrador VI-A**.

---

## 1. Estrutura de Dados: Representação por Matriz 2D

A parede de tijolos de cada nível é modelada utilizando uma **matriz bidimensional (2D)** de inteiros. Cada elemento da matriz representa uma posição específica na grade da tela:

$$\text{Matriz}[R][C]$$

Onde $R$ é o número de linhas (*rows*) e $C$ é o número de colunas (*columns*).

### **Mapeamento de Valores dos Blocos:**
* **`0`**: Célula vazia (sem tijolo).
* **`1`**: Tijolo Amarelo (Resistência: 1 impacto | Pontuação: 10 pts).
* **`2`**: Tijolo Laranja (Resistência: 1 impacto | Pontuação: 20 pts).
* **`3`**: Tijolo Vermelho (Resistência: 2 impactos | Pontuação: 30 pts).

---

## 2. Design dos 5 Níveis Obrigatórios

O jogo conta com **5 níveis sequenciais**. Conforme exigido no edital, a transição entre as fases ocorre de forma **automática** assim que o último bloco destruível da fase atual é removido.

### **Nível 1: A Parede Clássica (100% Preenchida)**
* **Método:** Matriz totalmente estática e preenchida (sem lacunas).
* **Objetivo:** Introduzir o jogador à mecânica básica do jogo.

```text
[
  [3, 3, 3, 3, 3, 3, 3, 3],
  [3, 3, 3, 3, 3, 3, 3, 3],
  [2, 2, 2, 2, 2, 2, 2, 2],
  [2, 2, 2, 2, 2, 2, 2, 2],
  [1, 1, 1, 1, 1, 1, 1, 1]
]
```

---

### **Nível 3: A Pirâmide (Geometria Escalonada)**
* **Método:** Formato geométrico simétrico com redução progressiva de colunas.
* **Objetivo:** Criar um funil de física onde a bola ricocheteia nos ângulos superiores.

```text
[
  [0, 0, 0, 3, 3, 0, 0, 0],
  [0, 0, 3, 3, 3, 3, 0, 0],
  [0, 2, 2, 2, 2, 2, 2, 0],
  [1, 1, 1, 1, 1, 1, 1, 1]
]
```

---

### **Nível 4: As Colunas e Túneis (Desafio Vertical)**
* **Método:** Blocos dispostos em colunas verticais com espaços vazios intermediários.
* **Objetivo:** Incentivar o jogador a lançar a bola pelos corredores verticais para prender a bola atrás dos tijolos.

```text
[
  [3, 3, 0, 3, 3, 0, 3, 3],
  [3, 3, 0, 3, 3, 0, 3, 3],
  [2, 2, 0, 2, 2, 0, 2, 2],
  [2, 2, 0, 2, 2, 0, 2, 2],
  [1, 1, 0, 1, 1, 0, 1, 1]
]
```

---

### **Nível 5: A Fortaleza (Máxima Resistência)**
* **Método:** Combinação de blocos resistentes (Vermelhos - `3`) na camada externa protegendo o núcleo.
* **Objetivo:** Testar a habilidade máxima do jogador antes da tela de vitória.

```text
[
  [3, 3, 3, 3, 3, 3, 3, 3],
  [3, 2, 2, 2, 2, 2, 2, 3],
  [3, 2, 1, 1, 1, 1, 2, 3],
  [3, 2, 2, 2, 2, 2, 2, 3],
  [3, 3, 3, 3, 3, 3, 3, 3]
]
```

---

## 3. Algoritmo de Renderização e Colisão no Flame Engine

A conversão da matriz 2D em componentes visuais renderizados na tela é realizada em tempo de execução (*runtime*) pela classe `LevelManager`:

1. **Varredura da Matriz:** O sistema percorre as linhas ($R$) e colunas ($C$) da matriz do nível ativo.
2. **Instanciação de Entidades:**
   * Para células com valor $> 0$, é gerado um objeto `BrickComponent`.
   * A posição $(X, Y)$ no canvas é calculada com base na largura/altura do bloco e nos offsets de margem:
     $$\\text{PosX} = \\text{MargemEsquerda} + C \\times (\\text{LarguraBloco} + \\text{Espaçamento})$$
     $$\\text{PosY} = \\text{MargemTopo} + R \\times (\\text{AlturaBloco} + \\text{Espaçamento})$$
3. **Detecção de Colisão:** Cada `BrickComponent` possui um `Hitbox` acoplado. Quando a bola atinge o bloco:
   * A resistência do bloco é decrementada.
   * Se a resistência chegar a `0`, o bloco é removido da árvore do jogo (`removeFromParent()`) e a pontuação é adicionada ao jogador.

---

## 4. Lógica de Progressão Automática de Fases

Para atender ao requisito de transição fluida:

* **Contador de Blocos Restantes:** A cada remoção de bloco, o gerenciador atualiza o total de blocos ativos no nível.
* **Condição de Vitória da Fase:** Quando `blocosRestantes == 0`:
  1. O jogo congela a bola temporariamente.
  2. É emitido o **efeito sonoro de conclusão de fase**.
  3. A matriz da próxima fase é carregada e instanciada.
  4. Se a fase concluída for a **Fase 5**, o jogador é redirecionado para a **Tela de Vitória Final**.
