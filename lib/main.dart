import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'brick_breaker_game.dart';
import 'widgets/main_menu_overlay.dart';
import 'widgets/start_splash_overlay.dart';
import 'widgets/members_overlay.dart';
import 'widgets/settings_overlay.dart';
import 'widgets/game_over_overlay.dart';
import 'widgets/victory_overlay.dart';

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
            'StartSplash': (context, game) => StartSplashOverlay(game: game),
            'MainMenu': (context, game) => MainMenuOverlay(game: game),
            'Members': (context, game) => MembersOverlay(game: game),
            'Settings': (context, game) => SettingsOverlay(game: game),
            'GameOver': (context, game) => GameOverOverlay(game: game),
            'Victory': (context, game) => VictoryOverlay(game: game),

            // Controles de teste no HUD
            'GameHud': (context, BrickBreakerGame game) {
              return SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, left: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 1. Botão VITÓRIA
                        ElevatedButton.icon(
                          onPressed: () {
                            game.triggerVictory();
                          },
                          icon: const Icon(
                            Icons.emoji_events,
                            color: Color(0xFFFFCC00),
                            size: 14,
                          ),
                          label: const Text(
                            'VITÓRIA',
                            style: TextStyle(
                              color: Color(0xFFFFCC00),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.75),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Color(0xFFFFCC00),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // 2. Botão LIMPA
                        ElevatedButton.icon(
                          onPressed: () {
                            // Chama o avanço de fase direto em 1 clique
                            game.nextLevel();
                          },
                          icon: const Icon(
                            Icons.flash_on,
                            color: Color(0xFFFF334B),
                            size: 14,
                          ),
                          label: const Text(
                            'STRIKE',
                            style: TextStyle(
                              color: Color(0xFFFF334B),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.75),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Color(0xFFFF334B),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          },
          initialActiveOverlays: const ['StartSplash'],
        ),
      ),
    );
  }
}