import 'package:flutter/material.dart';
import '../brick_breaker_game.dart';

class VictoryOverlay extends StatelessWidget {
  final BrickBreakerGame game;

  const VictoryOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final bool isLastLevel = game.currentLevel >= 5;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF131722),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00E5FF),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E5FF).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícone troféu
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0B0E14),
                  border: Border.all(color: const Color(0xFF00E5FF)),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Color(0xFF00E5FF),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // Título
              Text(
                isLastLevel ? 'FERA DEMAIS!!!' : 'NÍVEL CONCLUÍDO!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),

              // Subtítulo
              Text(
                isLastLevel
                    ? 'Parabéns! Você completou todos os 5 níveis!'
                    : 'Você destruiu todos os tijolos do Nível ${game.currentLevel}!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 28),

              // Botão próximo nível / Jogar novamente
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('Victory');
                    if (isLastLevel) {
                      game.currentLevel = 1;
                      game.resetGame();
                    } else {
                      game.nextLevel();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isLastLevel ? 'JOGAR NOVAMENTE' : 'PRÓXIMO NÍVEL',
                    style: const TextStyle(
                      color: Color(0xFF0B0E14),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Botão menu principal
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    game.overlays.remove('Victory');
                    game.overlays.add('MainMenu');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'MENU PRINCIPAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}