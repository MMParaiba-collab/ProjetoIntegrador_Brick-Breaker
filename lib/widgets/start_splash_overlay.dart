import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class StartSplashOverlay extends StatefulWidget {
  final FlameGame game;

  const StartSplashOverlay({super.key, required this.game});

  @override
  State<StartSplashOverlay> createState() => _StartSplashOverlayState();
}

class _StartSplashOverlayState extends State<StartSplashOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onStartPressed() async {
    try {
      // O primeiro clique físico do usuário libera a WebAudio API do Chrome
      await FlameAudio.bgm.play('bg_menu.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Erro ao iniciar áudio do menu: $e');
    }
    widget.game.overlays.remove('StartSplash');
    widget.game.overlays.add('MainMenu');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onStartPressed,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0E14),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sports_esports_rounded,
                size: 72,
                color: Color(0xFF00E5FF),
              ),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  'CLIQUE PARA INICIAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.5,
                    height: 1.5,
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