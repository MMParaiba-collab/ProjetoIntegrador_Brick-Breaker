import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/ball.dart';
import 'components/brick.dart';
import 'components/paddle.dart';
import 'components/score_text.dart';
import 'package:flame_audio/flame_audio.dart';

class BrickBreakerGame extends FlameGame 
    with HasCollisionDetection, HasKeyboardHandlerComponents, DragCallbacks {
  
  late Paddle paddle;
  late Ball ball;
  late HUDComponent hud;

  int lives = 3;
  int currentLevel = 1;
  final int maxLevels = 2; 

  @override
  Color backgroundColor() => const Color(0xFF090A15);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 1. Inicializa o modulo de musica de fundo
    FlameAudio.bgm.initialize();

    // 2. Pre-carrega todos os audios (musicas e efeitos) no cache global
    await FlameAudio.audioCache.loadAll([
      'bg_menu.mp3',
      'bg_gameplay.mp3',
      'paddle_hit.mp3',
      'brick_hit.mp3',
    ]);

    // Adiciona o Placar (HUD)
    hud = HUDComponent();
    add(hud);

    paddle = Paddle();
    add(paddle);

    ball = Ball();
    add(ball);

    // Carrega a Fase 1 ao iniciar
    loadBricksForLevel(currentLevel);
    
    pauseEngine();
  }

  // --- LÓGICA DE FASES E TRANSIÇÃO ---

  void checkLevelClearing() {
    // Filtra tijolos ativos no jogo
    final hasBricks = world.children.whereType<Brick>().isNotEmpty ||
        children.whereType<Brick>().isNotEmpty;

    if (!hasBricks) {
      if (currentLevel < maxLevels) {
        nextLevel();
      } else {
        triggerVictory(); // Ativa a vitória ao limpar a última fase
      }
    }
  }

  void nextLevel() {
    if (currentLevel < maxLevels) {
      currentLevel++;
    } else {
      currentLevel = 1;
    }

    // Esconde overlays de fim de jogo/vitória se estiverem abertos
    overlays.remove('GameOver');
    overlays.remove('Victory');

    resetBallAndPaddle();
    loadBricksForLevel(currentLevel);
    
    // Inicia a música de fundo durante o gameplay
    FlameAudio.bgm.play('bg_gameplay.mp3', volume: 0.5);
    
    resumeEngine();
  }

  void loadBricksForLevel(int level) {
    // Limpa tijolos anteriores
    world.children.whereType<Brick>().toList().forEach((b) => b.removeFromParent());
    children.whereType<Brick>().toList().forEach((b) => b.removeFromParent());

    if (level == 1) {
      _buildLevelOne();
    } else if (level == 2) {
      _buildLevelTwo();
    }
  }

  // Fase 1: Grade de Tijolos Tradicional
  void _buildLevelOne() {
    const rows = 5;
    const columns = 7;
    const brickHeight = 18.0;
    const padding = 6.0;

    final rowColors = [
      const Color(0xFF00E5FF),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFF00E5FF),
      const Color(0xFF8B5CF6),
    ];

    final brickWidth = (size.x - (padding * (columns + 1))) / columns;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        final x = padding + (c * (brickWidth + padding)) + (brickWidth / 2);
        final y = 110 + (r * (brickHeight + padding)) + (brickHeight / 2);

        add(
          Brick(
            position: Vector2(x, y),
            size: Vector2(brickWidth, brickHeight),
            color: rowColors[r],
          ),
        );
      }
    }
  }

  // Fase 2: Formato de Pirâmide com Tijolos Mais Resistentes
  void _buildLevelTwo() {
    const rows = 5;
    const columns = 7;
    const brickHeight = 18.0;
    const padding = 6.0;
    final brickWidth = (size.x - (padding * (columns + 1))) / columns;

    final colors = [
      const Color(0xFFFFD700),
      const Color(0xFFEC4899), 
      const Color(0xFF8B5CF6), 
      const Color(0xFF00E5FF), 
      const Color(0xFF00E5FF),
    ];

    for (int r = 0; r < rows; r++) {
      for (int c = r; c < columns - r; c++) {
        final x = padding + (c * (brickWidth + padding)) + (brickWidth / 2);
        final y = 110 + (r * (brickHeight + padding)) + (brickHeight / 2);

        final isHard = r == 0;

        add(Brick(
          position: Vector2(x, y),
          size: Vector2(brickWidth, brickHeight),
          color: colors[r % colors.length],
          health: isHard ? 2 : 1,
        ));
      }
    }
  }

  // --- REINÍCIO E CONTROLES DE PARTIDA ---

  void resetBallAndPaddle() {
    paddle.position = Vector2(size.x / 2, size.y - 50);
    ball.position = Vector2(size.x / 2, size.y - 80);
    ball.velocity = Vector2(200, -300);
  }

  void resetGame() {
    lives = 3;
    currentLevel = 1;
    loadBricksForLevel(currentLevel);
    resetBallAndPaddle();
    
    // Inicia a música de fundo
    FlameAudio.bgm.play('bg_gameplay.mp3', volume: 0.5);
    
    resumeEngine();
  }

  void onBallLost() {
    lives--;

    if (lives <= 0) {
      ball.velocity = Vector2.zero();
      FlameAudio.bgm.stop(); // Para a música ao perder
      pauseEngine();
      overlays.add('GameOver');
    } else {
      resetBallAndPaddle();
    }
  }

  void triggerVictory() {
    ball.velocity = Vector2.zero();
    FlameAudio.bgm.stop(); // Para a música na vitória
    pauseEngine();
    overlays.add('Victory');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final gridPaint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.05)
      ..strokeWidth = 1.0;

    const stepX = 30.0;
    const stepY = 30.0;

    for (double x = 0; x < size.x; x += stepX) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.y), gridPaint);
    }

    for (double y = 0; y < size.y; y += stepY) {
      canvas.drawLine(Offset(0, y), Offset(size.x, y), gridPaint);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) {
      paddle.position = Vector2(size.x / 2, size.y - 50);
      ball.position = Vector2(size.x / 2, size.y / 2 + 50);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    paddle.position.x += event.localDelta.x;
    final halfWidth = paddle.size.x / 2;
    paddle.position.x = paddle.position.x.clamp(halfWidth, size.x - halfWidth);
  }
}