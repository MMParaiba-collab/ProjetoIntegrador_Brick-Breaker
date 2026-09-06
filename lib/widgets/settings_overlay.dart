import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class SettingsOverlay extends StatefulWidget {
  final FlameGame game;

  const SettingsOverlay({super.key, required this.game});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  String selectedTheme = 'Neon';
  String selectedSize = 'Médio';

  final Map<String, List<Color>> themePalettes = {
    'Neon': [
      const Color(0xFF00E5FF),
      const Color(0xFFA78BFA),
      const Color(0xFFFF2A85),
    ],
    'Fogo': [
      const Color(0xFFFF3B30),
      const Color(0xFFFF9500),
      const Color(0xFFFFCC00),
    ],
    'Oceano': [
      const Color(0xFF007AFF),
      const Color(0xFF00E5FF),
      const Color(0xFF34C759),
    ],
    'Clássico': [
      const Color(0xFFFF9500),
      const Color(0xFFFFCC00),
      const Color(0xFF34C759),
    ],
  };

  void _goBack() {
    widget.game.overlays.remove('Settings');
    widget.game.overlays.add('MainMenu');
  }

  void _saveSettings() {
    // Salvar as preferências do jogador ou aplicar no jogo
    _goBack();
  }

  @override
  Widget build(BuildContext context) {
    final activeColors = themePalettes[selectedTheme]!;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E2723),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFF6D00)),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: Color(0xFFFF6D00),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configurações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Personalize o jogo',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Padrão de cores tijolos
              const Text(
                'PADRÃO DE CORES DOS TIJOLOS',
                style: TextStyle(
                  color: Color(0xFF707E94),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _buildThemeCard('Neon', 'Ciano · Roxo · Rosa', [
                    const Color(0xFF00E5FF),
                    const Color(0xFFA78BFA),
                    const Color(0xFFFF2A85),
                    const Color(0xFF00E5FF),
                  ]),
                  _buildThemeCard('Fogo', 'Vermelho · Laranja · Amarelo', [
                    const Color(0xFFFF3B30),
                    const Color(0xFFFF9500),
                    const Color(0xFFFFCC00),
                    const Color(0xFFFFCC00),
                  ]),
                  _buildThemeCard('Oceano', 'Azul · Ciano · Verde', [
                    const Color(0xFF007AFF),
                    const Color(0xFF00E5FF),
                    const Color(0xFF34C759),
                    const Color(0xFF007AFF),
                  ]),
                  _buildThemeCard('Clássico', 'Multicolorido', [
                    const Color(0xFF007AFF),
                    const Color(0xFFFF9500),
                    const Color(0xFFFFCC00),
                    const Color(0xFF34C759),
                  ]),
                ],
              ),

              const SizedBox(height: 24),

              // Tamanho dos tijolos
              const Text(
                'TAMANHO DOS TIJOLOS',
                style: TextStyle(
                  color: Color(0xFF707E94),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _buildSizeCard('Pequeno', 4)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSizeCard('Médio', 3)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSizeCard('Grande', 2)),
                ],
              ),

              const SizedBox(height: 24),

              // Pré-visualização
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131722),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PRÉ-VISUALIZAÇÃO',
                      style: TextStyle(
                        color: Color(0xFF707E94),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(3, (rowIndex) {
                      final color = activeColors[rowIndex % activeColors.length];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: List.generate(6, (colIndex) {
                            return Expanded(
                              child: Container(
                                height: selectedSize == 'Pequeno'
                                    ? 12
                                    : (selectedSize == 'Médio' ? 16 : 20),
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withOpacity(0.6),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Botão Salvar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFFFF5722).withOpacity(0.5),
                  ),
                  child: const Text(
                    'SALVAR CONFIGURAÇÕES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Botão voltar sem salvar
              Center(
                child: TextButton(
                  onPressed: _goBack,
                  child: const Text(
                    '← VOLTAR SEM SALVAR',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
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

  Widget _buildThemeCard(
      String title, String subtitle, List<Color> sampleColors) {
    final isSelected = selectedTheme == title;
    return GestureDetector(
      onTap: () => setState(() => selectedTheme = title),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF131722),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(0.3),
                    blurRadius: 10,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: sampleColors
                  .map((c) => Expanded(
                        child: Container(
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          decoration: BoxDecoration(
                            color: c,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF00E5FF) : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 9,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeCard(String label, int lineCount) {
    final isSelected = selectedSize == label;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = label),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF131722),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(0.3),
                    blurRadius: 10,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: List.generate(
                lineCount,
                (index) => Container(
                  height: 4,
                  width: 36,
                  margin: const EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF00E5FF)
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF00E5FF) : Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}