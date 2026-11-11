import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Дерев'яна дошка з ледь помітною текстурою корка позаду всього екрана.
class CorkboardBackground extends StatelessWidget {
  final Widget child;
  const CorkboardBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.woodLight, AppColors.wood, AppColors.woodDark],
        ),
      ),
      child: CustomPaint(
        painter: _CorkDotsPainter(),
        child: child,
      ),
    );
  }
}

class _CorkDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(7);
    final paint = Paint()..color = Colors.black.withOpacity(0.12);
    for (int i = 0; i < 60; i++) {
      final dx = rnd.nextDouble() * size.width;
      final dy = rnd.nextDouble() * size.height;
      final r = 1.5 + rnd.nextDouble() * 2.5;
      canvas.drawCircle(Offset(dx, dy), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
