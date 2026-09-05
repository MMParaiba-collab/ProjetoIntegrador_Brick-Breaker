import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'ball.dart';

class Brick extends PositionComponent with CollisionCallbacks {
  final Color color;

  Brick({required Vector2 position, required Vector2 size, required this.color})
      : super(position: position, size: size, anchor: Anchor.center) {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(4)),
      paint,
    );
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ball) {
      removeFromParent();
    }
  }
}