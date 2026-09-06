import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class MainMenuOverlay extends StatefulWidget {
  
  final FlameGame game;
  const MainMenuOverlay({super.key, required this.game});

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
    
    bool _isMuted = false;

@override
  void initState() {
    super.initState();
    // Toca a música do menu ao abrir a tela inicial
    _playMenuAudio();
  }

  Future<void> _playMenuAudio() async {
    if (_isMuted) return;
    try {
      await FlameAudio.bgm.play('bg_menu.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Aguardando interação para áudio: $e');
    }
  }

  void _toggleAudio() {
    setState(() {
      _isMuted = !_isMuted;
    });

    if (_isMuted) {
      FlameAudio.bgm.stop();
    } else {
      _playMenuAudio();
    }
  }

  @override
  void dispose() {
    // Para a música quando o overlay for removido
    FlameAudio.bgm.stop();
    super.dispose();
  }

  void _onInteraction() {
    if (!FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.play('bg_menu.mp3', volume: 0.5);
    }
  }

Future<void> _startGame() async {
    try {
      // Encerra a música do menu
      await FlameAudio.bgm.stop();

      // 2. Toca a música da gameplay em loop
      if (!_isMuted) {
        await FlameAudio.loop('bg_gameplay.mp3', volume: 0.2);
      }
    } catch (e) {
      debugPrint('Erro ao iniciar áudio da gameplay: $e');
    }

    // Remove o menu e inicia a engine
    widget.game.overlays.remove('MainMenu');
    widget.game.resumeEngine();
  }

void _openMembers() {
  // Esconde o menu principal e abre a tela de integrantes
  widget.game.overlays.remove('MainMenu');
  widget.game.overlays.add('Members');
}

void _openSettings() {
  widget.game.overlays.remove('MainMenu');
  widget.game.overlays.add('Settings');
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridBackgroundPainter(),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 16,
            child: SafeArea(
              child: IconButton(
                onPressed: _toggleAudio,
                icon: Icon(
                  _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: _isMuted ? const Color(0xFFEF4444) : const Color(0xFF00E5FF),
                  size: 18,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF131722),
                  padding: const EdgeInsets.all(12),
                  side: BorderSide(
                    color: _isMuted ? const Color(0xFFEF4444) : const Color(0xFF00E5FF),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const _BrickLogo(),
                  const SizedBox(height: 24),
                  const Text(
                    'BRICK',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4.0,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF00E5FF), Color(0xFF8B5CF6)],
                    ).createShader(bounds),
                    child: const Text(
                      'BREAKER',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4.0,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PROJETO INTEGRADOR · 2026',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Spacer(flex: 3),
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00E5FF),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _startGame,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded, color: Colors.black, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'JOGAR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _SecondaryButton(
                          icon: Icons.group_rounded,
                          label: 'INTEGRANTES',
                          borderColor: const Color(0xFF3B2D54),
                          textColor: const Color(0xFFA78BFA),
                          onPressed: _openMembers,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SecondaryButton(
                          icon: Icons.settings_rounded,
                          label: 'CONFIGURAÇÕES',
                          borderColor: const Color(0xFF4A2B23),
                          textColor: const Color(0xFFFB923C),
                          onPressed: _openSettings,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                  const Text(
                    'Use o paddle para destruir todos os tijolos',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget do Logo de Blocos
class _BrickLogo extends StatelessWidget {
  const _BrickLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBrick(const Color(0xFF00E5FF)),
            const SizedBox(width: 6),
            _buildBrick(const Color(0xFFFF6B00)),
            const SizedBox(width: 6),
            _buildBrick(const Color(0xFF8B5CF6)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBrick(const Color(0xFF8B5CF6)),
            const SizedBox(width: 6),
            _buildBrick(const Color(0xFF00E5FF)),
            const SizedBox(width: 6),
            _buildBrick(const Color(0xFFFF6B00)),
          ],
        ),
      ],
    );
  }

  Widget _buildBrick(Color color) {
    return Container(
      width: 32,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

// Widget dos botões secundários
class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor, width: 1.5),
        backgroundColor: const Color(0xFF131722),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Fundo com efeito grade
class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2640).withOpacity(0.2)
      ..strokeWidth = 1.0;

    const gridSize = 40.0;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}