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

      ```

2. **Executar em modo de desenvolvimento (Debug):**
   ```bash
   flutter run
   ```

3. **Gerar o arquivo APK de Release (Produção):**
   ```bash
   flutter build apk --release
   ```
   * O arquivo APK final será gerado no diretório:  
     `build/app/outputs/flutter-apk/app-release.apk`

4. **Gerar o arquivo APK para testes rápidos (Debug):**
   ```bash
   flutter build apk --debug
   ```

---

## 5. Estrutura de Arquivos e Diretórios do Projeto

A organização do código-fonte segue a estrutura padrão do Flutter separando a lógica do jogo, componentes e interfaces:

```text
ProjetoIntegrador_Brick-Breaker/
├── .github/              # Configurações de automação e workflows
├── android/              # Configurações nativas do Android e manifesto
├── assets/               # Recursos estáticos (áudios, imagens, fontes)
│   ├── audio/            # Efeitos sonoros de impacto e transição
│   └── images/           # Sprites e texturas dos blocos e paddle
├── docs/                 # Documentação técnica Markdown do projeto
│   ├── game_rules.md
│   ├── level_design.md
│   ├── tech_stack.md
│   └── wireframes.md
├── lib/                  # Código-fonte principal em Dart
│   ├── components/       # Entidades Flame (Ball, Paddle, Brick)
│   ├── config/           # Constantes, cores e configurações de níveis
│   ├── screens/          # Telas do app (Home, Configurações, Game, GameOver)
│   └── main.dart         # Ponto de entrada do aplicativo
├── .gitignore            # Arquivos ignorados pelo Git
├── pubspec.yaml          # Gerenciador de dependências e assets do Flutter
├── README.md             # Página principal e sumário do repositório
└── Wireframes.png        # Protótipo de alta fidelidade
```

---

## 6. Considerações de Performance e Compatibilidade

* **Taxa de Quadros (FPS):** O loop de jogo do Flame Engine é otimizado para manter 60 FPS estáveis na maioria dos dispositivos Android modernos.
* **Orientação de Tela:** O aplicativo é configurado para rodar em modo **Retrato (Portrait)**, otimizando o espaço vertical para o rebatedor e a matriz de tijolos.
* **Versão Mínima do Android:** Compatível a partir do Android 5.0 (Lollipop / API level 21).
