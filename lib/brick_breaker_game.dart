import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/ball.dart';
import 'components/brick.dart';
import 'components/paddle.dart';
import 'components/score_text.dart';

class BrickBreakerGame extends FlameGame 
    with HasCollisionDetection, HasKeyboardHandlerComponents, DragCallbacks {
  
  late Paddle paddle;
  late Ball ball;
  late HUDComponent hud;

  @override
  Color backgroundColor() => const Color(0xFF090A15);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Adiciona o Placar (HUD)
    hud = HUDComponent();
    add(hud);

    paddle = Paddle();
    add(paddle);

    ball = Ball();
    add(ball);

    _buildBrickGrid();
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
        final y = 100 + (r * (brickHeight + padding)) + (brickHeight / 2);

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
}