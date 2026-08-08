# Ambiente de Desenvolvimento, Tecnologias e Build do APK

Este documento detalha o ecossistema tecnológico, as ferramentas de desenvolvimento, os padrões de projeto e o processo de compilação (*build*) do arquivo **APK** do aplicativo **Brick Breaker**, desenvolvido para a disciplina de **Projeto Integrador VI-A**.

---

## 1. Tecnologias e Frameworks Utilizados

### **1.1. Linguagem e Framework Principal**
* **Flutter (SDK v3.x):** Framework UI de código aberto criado pelo Google para a construção de aplicações multiplataforma de alta performance a partir de uma única base de código.
* **Dart:** Linguagem de programação orientada a objetos e fortemente tipada utilizada pelo Flutter, otimizada para a criação de interfaces de usuário reativas.

### **1.2. Motor de Jogo (Game Engine)**
* **Flame Engine (v1.x):** Pacote modular construído sobre o Flutter que fornece um loop de jogo (*Game Loop*) de alta performance, gerenciamento de entidades/componentes (ECS), sistema de física 2D e detecção rigorosa de colisões.

### **1.3. Áudio e Efeitos Sonoros**
* **Flame Audio / Audioplayers:** Biblioteca integrada para gerenciamento de áudio com baixa latência, utilizada para emitir efeitos sonoros durante os eventos de colisão (bola no *paddle*) e transição de fases.

---

## 2. Ambiente de Desenvolvimento e Ferramentas

Para garantir a padronização e colaboração entre os membros da equipe, o ambiente foi configurado com as seguintes ferramentas:

| Ferramenta | Descrição / Finalidade |
| :--- | :--- |
| **VS Code / Android Studio** | IDEs de desenvolvimento com suporte estendido para Flutter e Dart. |
| **Git & GitHub** | Controle de versão distribuído, com histórico incremental e branches de funcionalidade. |
| **Figma / Penpot** | Prototipagem e criação dos wireframes de alta fidelidade das telas. |
| **Android SDK / Emulator** | Emulação de dispositivos móveis para testes de usabilidade e responsividade em diferentes resoluções. |

---

## 3. Padronização de Commits (*Conventional Commits*)

O repositório segue estritamente a convenção do **Conventional Commits** para manter o histórico claro e legível. Os prefixos utilizados nas mensagens de commit incluem:

* `feat:` Introdução de um novo recurso ou funcionalidade (ex: `feat: implementa colisão da bola com os tijolos`).
* `fix:` Correção de um bug ou comportamento inesperado (ex: `fix: ajusta travamento da bola na borda lateral`).
* `docs:` Alterações e inclusões na documentação Markdown (ex: `docs: adiciona tech_stack.md`).
* `style:` Ajustes de formatação ou estilo de código sem impacto na lógica.
* `refactor:` Refatoração de código sem alteração de comportamento externo.

---

## 4. Processo de Gerador e Build do Arquivo APK

Para entregar o aplicativo executável para dispositivos Android (`.apk`), o processo de compilação segue o fluxo especificado abaixo.

### **4.1. Pré-requisitos para Build**
1. Flutter SDK instalado e configurado nas variáveis de ambiente.
2. Android SDK Command-line Tools e licenças do Android aceitas (`flutter doctor --android-licenses`).
3. Dispositivo virtual (emulador) ou físico com modo de depuração USB ativado.

### **4.2. Comandos para Compilação**

1. **Obter as dependências do projeto:**
   ```bash
   flutter pub get
