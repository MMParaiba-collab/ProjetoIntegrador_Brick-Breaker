import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'paddle.dart';

class Ball extends CircleComponent 
    with CollisionCallbacks, HasGameReference {
  
  Vector2 velocity = Vector2(150, -280);

  Ball() : super(radius: 8, anchor: Anchor.center) {
    add(CircleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.x - radius <= 0 || position.x + radius >= game.size.x) {
      velocity.x = -velocity.x;
    }

    if (position.y - radius <= 0) {
      velocity.y = -velocity.y;
    }

    if (position.y + radius >= game.size.y) {
      position = Vector2(game.size.x / 2, game.size.y / 2 + 100);
      velocity = Vector2(150, -280);
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Paddle) {
      final relativeIntersectX = (position.x - other.position.x) / (other.size.x / 2);
      velocity.x = relativeIntersectX * 300;
      velocity.y = -velocity.y.abs();
    }
  }
}