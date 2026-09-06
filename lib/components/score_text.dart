import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'brick.dart';

class HUDComponent extends PositionComponent with TapCallbacks, HasGameRef {
  
  int score = 240;
  int lives = 3;
  int level = 1;

  late TextComponent titleText;
  late TextComponent scoreText;

  Function()? onClosePressed;
  Function(int)? onLevelSelect;

  HUDComponent({this.onClosePressed, this.onLevelSelect}) : super(priority: 10);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    titleText = TextComponent(
      text: 'NÍVEL $level · CLÁSSICO',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF8A99AD),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
    add(titleText);

    scoreText = TextComponent(
      text: '$score',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF00E5FF),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(scoreText);
  }

  void updateHUD({required int newScore, required int newLives, required int newLevel}) {
    score = newScore;
    lives = newLives;
    level = newLevel;
    scoreText.text = '$score';
    
    final levelNames = {
      1: 'CLÁSSICO',
      2: 'PIRÂMIDE',
      3: 'XADREZ',
      4: 'DIAMANTE',
      5: 'FORTALEZA',
    };
    final levelName = levelNames[level] ?? 'CLÁSSICO';
    titleText.text = 'NÍVEL $level · $levelName';
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    position = Vector2.zero();

    titleText.position = Vector2(size.x / 2, 15);
    scoreText.position = Vector2(size.x / 2, 30);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final closeBgPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    final closeRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(16, 15, 32, 32),
      const Radius.circular(8),
    );
    canvas.drawRRect(closeRect, closeBgPaint);

    final xPaint = Paint()
      ..color = const Color(0xFF8A99AD)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(26, 25), const Offset(38, 37), xPaint);
    canvas.drawLine(const Offset(38, 25), const Offset(26, 37), xPaint);

    final lifePaint = Paint()..color = const Color(0xFFFF6D00);
    final startX = size.x - 60;
    for (int i = 0; i < lives; i++) {
      canvas.drawCircle(Offset(startX + (i * 14), 30), 5, lifePaint);
    }

    const btnWidth = 45.0;
    const btnHeight = 28.0;
    const spacing = 8.0;
    final totalWidth = (5 * btnWidth) + (4 * spacing);
    final startBtnX = (size.x - totalWidth) / 2;
    const btnY = 62.0;

    for (int i = 1; i <= 5; i++) {
      final isSelected = i == level;
      final x = startBtnX + ((i - 1) * (btnWidth + spacing));

      final bgPaint = Paint()
        ..color = isSelected ? const Color(0xFF00E5FF).withOpacity(0.15) : const Color(0xFF121826)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isSelected ? const Color(0xFF00E5FF) : const Color(0xFF1E293B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 1.5 : 1.0;

      final btnRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, btnY, btnWidth, btnHeight),
        const Radius.circular(6),
      );

      canvas.drawRRect(btnRect, bgPaint);
      canvas.drawRRect(btnRect, borderPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(
            color: isSelected ? const Color(0xFF00E5FF) : const Color(0xFF475569),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x + (btnWidth - textPainter.width) / 2, btnY + (btnHeight - textPainter.height) / 2),
      );
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    final pos = event.localPosition;

    if (pos.x >= 16 && pos.x <= 48 && pos.y >= 15 && pos.y <= 47) {
      onClosePressed?.call();
    }

    const btnWidth = 45.0;
    const btnHeight = 28.0;
    const spacing = 8.0;
    final totalWidth = (5 * btnWidth) + (4 * spacing);
    final startBtnX = (size.x - totalWidth) / 2;
    const btnY = 62.0;

    if (pos.y >= btnY && pos.y <= btnY + btnHeight) {
      for (int i = 1; i <= 5; i++) {
        final x = startBtnX + ((i - 1) * (btnWidth + spacing));
        if (pos.x >= x && pos.x <= x + btnWidth) {
          _selectLevel(i);
          onLevelSelect?.call(i);
          break;
        }
      }
    }
  }

  void _selectLevel(int selectedLevel) {
    score = 0;
    updateHUD(newScore: score, newLives: lives, newLevel: selectedLevel);

    // Remove todos os tijolos que estão no jogo
    final currentBricks = gameRef.children.whereType<Brick>().toList();
    for (final brick in currentBricks) {
      brick.removeFromParent();
    }

    switch (selectedLevel) {
      case 2:
        _buildPyramid();
        break;
      case 3:
        _buildChessboard();
        break;
      case 4:
        _buildDiamond();
        break;
      case 5:
        _buildFortress();
        break;
    }
  }

  void _buildPyramid() {
    const rows = 5;
    const columns = 7;
    const brickHeight = 18.0;
    const padding = 6.0;

    // Usa a largura real da tela do jogo para centralizar
    final totalWidth = gameRef.size.x;
    const sideMargin = 16.0;
    final usableWidth = totalWidth - (sideMargin * 2);
    final brickWidth = (usableWidth - (padding * (columns - 1))) / columns;

    final colors = [
      const Color(0xFFFFD700),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
      const Color(0xFF00E5FF),
      const Color(0xFF00E5FF),
    ];

    for (int r = 0; r < rows; r++) {
      for (int c = r; c < columns - r; c++) {
        final x = sideMargin + (c * (brickWidth + padding));
        final y = 110.0 + (r * (brickHeight + padding));

        final brick = Brick(
          position: Vector2(x, y),
          size: Vector2(brickWidth, brickHeight),
          color: colors[r % colors.length],
        );
        gameRef.add(brick);
      }
    }
  }

  void _buildChessboard() {
    const rows = 6;
    const columns = 6;
    const brickHeight = 18.0;
    const padding = 6.0;

    final totalWidth = gameRef.size.x;
    const sideMargin = 16.0;
    final usableWidth = totalWidth - (sideMargin * 2);
    final brickWidth = (usableWidth - (padding * (columns - 1))) / columns;

    final colorA = const Color(0xFF00E5FF);
    final colorB = const Color(0xFFEC4899);

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        if ((r + c) % 2 == 0) {
          final x = sideMargin + (c * (brickWidth + padding));
          final y = 110.0 + (r * (brickHeight + padding));

          final brick = Brick(
            position: Vector2(x, y),
            size: Vector2(brickWidth, brickHeight),
            color: (r % 2 == 0) ? colorA : colorB,
          );
          gameRef.add(brick);
        }
      }
    }
  }

  void _buildDiamond() {
    const rows = 7;
    const columns = 7;
    const brickHeight = 18.0;
    const padding = 6.0;

    final totalWidth = gameRef.size.x;
    const sideMargin = 16.0;
    final usableWidth = totalWidth - (sideMargin * 2);
    final brickWidth = (usableWidth - (padding * (columns - 1))) / columns;

    final colors = [
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFFFFD700),
      const Color(0xFF00E5FF),
      const Color(0xFFFFD700),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
    ];

    final center = rows ~/ 2;

    for (int r = 0; r < rows; r++) {
      final distanceFromCenter = (r - center).abs();
      final countInRow = columns - (distanceFromCenter * 2);
      final startCol = distanceFromCenter;

      for (int c = startCol; c < startCol + countInRow; c++) {
        final x = sideMargin + (c * (brickWidth + padding));
        final y = 110.0 + (r * (brickHeight + padding));

        final brick = Brick(
          position: Vector2(x, y),
          size: Vector2(brickWidth, brickHeight),
          color: colors[r % colors.length],
        );
        gameRef.add(brick);
      }
    }
  }

  void _buildFortress() {
    const rows = 6;
    const columns = 6;
    const brickHeight = 18.0;
    const padding = 6.0;

    final totalWidth = gameRef.size.x;
    const sideMargin = 16.0;
    final usableWidth = totalWidth - (sideMargin * 2);
    final brickWidth = (usableWidth - (padding * (columns - 1))) / columns;

    const wallColor = Color(0xFF8B5CF6);
    const coreColor = Color(0xFFFFD700);

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        final isBorder = (r == 0 || r == rows - 1 || c == 0 || c == columns - 1);
        final isCenter = (r >= 2 && r <= 3 && c >= 2 && c <= 3);

        if (isBorder || isCenter) {
          final x = sideMargin + (c * (brickWidth + padding));
          final y = 110.0 + (r * (brickHeight + padding));

          final brick = Brick(
            position: Vector2(x, y),
            size: Vector2(brickWidth, brickHeight),
            color: isBorder ? wallColor : coreColor,
          );
          gameRef.add(brick);
        }
      }
    }
  }
}