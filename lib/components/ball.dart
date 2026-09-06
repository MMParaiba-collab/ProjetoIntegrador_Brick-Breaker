import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'brick.dart';
import 'paddle.dart';
import 'score_text.dart';

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

   // Bola passou do paddle (limite inferior)
    if (position.y + radius >= game.size.y) {
      final hud = game.world.children.whereType<HUDComponent>().firstOrNull ??
          game.children.whereType<HUDComponent>().firstOrNull;

      if (hud != null) {
        hud.lives -= 1;
        hud.updateHUD(
          newScore: hud.score,
          newLives: hud.lives,
          newLevel: hud.level,
        );

        // Se zerar as vidas, exibe o Game Over e para o jogo
        if (hud.lives <= 0) {
          velocity = Vector2.zero();
          game.pauseEngine();
          game.overlays.add('GameOver');
          return;
        }
      }

      // Se ainda restarem vidas, reseta a bola para tentar de novo
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

    if (other is Brick) {
      velocity.y = -velocity.y;
      other.removeFromParent();

      final hud = game.world.children.whereType<HUDComponent>().firstOrNull ??
                  game.children.whereType<HUDComponent>().firstOrNull;

      if (hud != null) {
        hud.score += 10;
        hud.updateHUD(
          newScore: hud.score,
          newLives: hud.lives,
          newLevel: hud.level,
        );
      }
    }
  }
}