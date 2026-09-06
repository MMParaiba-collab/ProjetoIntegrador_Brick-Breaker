import 'package:flutter/material.dart';
import '../brick_breaker_game.dart';

class GameOverOverlay extends StatelessWidget {
  
  final BrickBreakerGame game;
  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFFFF2A85),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF2A85).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícone Estrela Neon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0B0E14),
                  border: Border.all(color: const Color(0xFFFF2A85)),
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFF2A85),
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),

              // Título
              const Text(
                'GAME OVER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),

              // Subtítulo / Motivo
              Text(
                'A bola passou pelo paddle - Nível ${game.currentLevel}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 28),

              // Botão Reiniciar Nível
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('GameOver');
                    game.resetGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2A85),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'REINICIAR NÍVEL ATUAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Botão próximo nível
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    game.overlays.remove('GameOver');
                    game.nextLevel();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00E5FF),
                    side: const BorderSide(color: Color(0xFF00E5FF)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'PRÓXIMO NÍVEL',
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