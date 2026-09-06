import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'ball.dart';
import 'package:flame_audio/flame_audio.dart';

class Brick extends PositionComponent with CollisionCallbacks {
  Color color;
  int health;

  Brick({
    required Vector2 position,
    required Vector2 size,
    required this.color,
    this.health = 1,
  }) : super(position: position, size: size, anchor: Anchor.center) {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rect = size.toRect();
    
    final paint = Paint()
      ..color = health > 1 ? color : color.withOpacity(0.85);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      paint,
    );

    if (health > 1) {
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        borderPaint,
      );
    }
  }
  @override
void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
  super.onCollisionStart(intersectionPoints, other);

  if (other is Ball) {
    // som de destruição/impacto do tijolo
    FlameAudio.play('brick_hit.mp3', volume: 0.5);
    
    // Remove o tijolo do jogo
    removeFromParent();
    }
  }
}