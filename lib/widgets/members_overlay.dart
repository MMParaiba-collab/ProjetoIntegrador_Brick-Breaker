import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MembersOverlay extends StatelessWidget {
  final FlameGame game;

  const MembersOverlay({super.key, required this.game});

  final List<Map<String, String>> _members = const [
    {'id': '1', 'initial': 'M', 'name': 'Matheus Mari Paraiba'},
    {'id': '2', 'initial': 'G', 'name': 'Gabriel Silveira Jaiger'},
    {'id': '3', 'initial': 'J', 'name': 'Jose Carlos Rojas Velasquez'},
    {'id': '4', 'initial': 'J', 'name': 'Julio Capellari Santos'},
  ];

  void _goBack() {
    game.overlays.remove('Members');
    game.overlays.add('MainMenu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Cabeçalho
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131722),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF00E5FF).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _goBack,
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF00E5FF),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF0B0E14),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            'INTEGRANTES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Grupo do Projeto',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Lista de integrantes
              Expanded(
                child: ListView.separated(
                  itemCount: _members.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final member = _members[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131722),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF00E5FF).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Quadrado com inicial
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B0E14),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFF00E5FF).withOpacity(0.5),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              member['initial']!,
                              style: const TextStyle(
                                color: Color(0xFF00E5FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Nome do integrante
                          Expanded(
                            child: Text(
                              member['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // Quadrado com ID
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B0E14),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              member['id']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Botão voltar inferior
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: const Text(
                    'VOLTAR',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00E5FF),
                    backgroundColor: const Color(0xFF131722),
                    side: const BorderSide(
                      color: Color(0xFF00E5FF),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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