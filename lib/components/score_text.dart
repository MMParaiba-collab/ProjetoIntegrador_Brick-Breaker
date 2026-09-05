import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HUDComponent extends PositionComponent {
  int score = 240;
  int lives = 3;

  late TextComponent titleText;
  late TextComponent scoreText;

  HUDComponent() : super(priority: 10); // Priority 10 pra ficar na frente dos tijolos

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    titleText = TextComponent(
      text: 'NÍVEL 1 · CLÁSSICO',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF8A99AD),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
    add(titleText);

    scoreText = TextComponent(
      text: '$score',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF00E5FF),
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(scoreText);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = Vector2(size.x / 2, 20);
    titleText.position = Vector2(0, 0);
    scoreText.position = Vector2(0, 18);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 3 bolinhas de vida
    final paint = Paint()..color = const Color(0xFFFF5252);
    const startX = 80.0;
    for (int i = 0; i < lives; i++) {
      canvas.drawCircle(Offset(startX + (i * 16), 10), 6, paint);
    }
  }
}