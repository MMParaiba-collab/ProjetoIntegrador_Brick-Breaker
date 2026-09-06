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

void resetBallAndPaddle() {
  // Reposiciona o paddle no centro inferior
  paddle.position = Vector2(size.x / 2, size.y - 50);

  // Reposiciona a bola acima do paddle
  ball.position = Vector2(size.x / 2, size.y - 80);

  // Define a velocidade inicial da bola para subir
  ball.velocity = Vector2(200, -300);
}

void onBallLost() {
  lives--;

  if (lives <= 0) {
    // Para a bola
    ball.velocity = Vector2.zero();
    
    // Pausa o motor e exibe o Overlay
    pauseEngine();
    overlays.add('GameOver');
  } else {
    resetBallAndPaddle();
  }
}

void resetGame() {
  lives = 3;
  // Recarrega os tijolos e reposiciona bola/paddle
  resetBallAndPaddle();
  resumeEngine();
}

void nextLevel() {
  currentLevel++;
  resetGame();
}

@override
void render(Canvas canvas) {
  // Efeito grade do fundo
  super.render(canvas);

  final gridPaint = Paint()
    ..color = const Color(0xFF00E5FF).withOpacity(0.05)
    ..strokeWidth = 1.0;

  const stepX = 30.0; // Espaçamento horizontal
  const stepY = 30.0; // Espaçamento vertical

  // Linhas Verticais
  for (double x = 0; x < size.x; x += stepX) {
    canvas.drawLine(Offset(x, 0), Offset(x, size.y), gridPaint);
  }

  // Linhas Horizontais
  for (double y = 0; y < size.y; y += stepY) {
    canvas.drawLine(Offset(0, y), Offset(size.x, y), gridPaint);
  }
}

  @override
  Color backgroundColor() => const Color(0xFF090A15);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Pré-carrega o áudio no cache
 await FlameAudio.audioCache.loadAll([
      'bg_menu.mp3',
      'bg_gameplay.mp3',
      'paddle_hit.mp3',
      'brick_hit.mp3',
    ]);

  pauseEngine();

    // Adiciona o Placar (HUD)
    hud = HUDComponent();
    add(hud);

    paddle = Paddle();
    add(paddle);

    ball = Ball();
    add(ball);

    _buildBrickGrid();
    
    pauseEngine();
  }

  void _buildBrickGrid() {
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

  void _buildPyramidPattern() {
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
}