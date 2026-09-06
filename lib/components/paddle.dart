import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'ball.dart';

class Paddle extends PositionComponent with CollisionCallbacks {
  Paddle() : super(size: Vector2(100, 16), anchor: Anchor.center) {
    add(RectangleHitbox());
  }

@override
void render(Canvas canvas) {
  super.render(canvas);
  final rect = size.toRect();
  final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

  // Sombra neon
  final glowPaint = Paint()
    ..color = const Color(0xFF00E5FF).withOpacity(0.6)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
  canvas.drawRRect(rrect, glowPaint);

  // Preenchimento principal com gradiente
  final fillPaint = Paint()
    ..shader = const LinearGradient(
      colors: [Color(0xFF00E5FF), Color(0xFF8B5CF6)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(rect);
  canvas.drawRRect(rrect, fillPaint);

  // Borda iluminada
  final borderPaint = Paint()
    ..color = Colors.white.withOpacity(0.5)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  canvas.drawRRect(rrect, borderPaint);
}

@override
void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
  super.onCollisionStart(intersectionPoints, other);

  if (other is Ball) {
    // som da rebatida no paddle
    FlameAudio.play('paddle_hit.mp3', volume: 1.0);
    }
  }
}