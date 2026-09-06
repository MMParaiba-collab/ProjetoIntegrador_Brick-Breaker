import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'brick_breaker_game.dart';
import 'widgets/main_menu_overlay.dart';
import 'widgets/start_splash_overlay.dart';
import 'widgets/members_overlay.dart';
import 'widgets/settings_overlay.dart';
import 'widgets/game_over_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget<BrickBreakerGame>(
          game: BrickBreakerGame(),
          overlayBuilderMap: {
            // Mapeia a nova tela de splash
            'StartSplash': (context, game) => StartSplashOverlay(game: game),
            'MainMenu': (context, game) => MainMenuOverlay(game: game),
            'Members': (context, game) => MembersOverlay(game: game),
            'Settings': (context, game) => SettingsOverlay(game: game),
            'GameOver': (context, game) => GameOverOverlay(game: game),
          },
          // Define a StartSplash como a primeira tela ativa
          initialActiveOverlays: const ['StartSplash'],
        ),
      ),
    );
  }
}