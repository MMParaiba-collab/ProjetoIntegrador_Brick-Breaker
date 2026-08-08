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
