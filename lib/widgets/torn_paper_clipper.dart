import 'dart:math';
import 'package:flutter/material.dart';

/// Вирізає нерівний, "рваний" край паперу зверху і знизу картки.
/// [seed] фіксує форму для конкретної картки, щоб вона не "тремтіла"
/// між перебудовами.
class TornPaperClipper extends CustomClipper<Path> {
  final int seed;
  const TornPaperClipper({this.seed = 0});

  @override
  Path getClip(Size size) {
    final rnd = Random(seed);
    const double jag = 5.0;
    final path = Path();

    double x = 0;
    path.moveTo(0, rnd.nextDouble() * jag);
    while (x < size.width) {
      x += 12 + rnd.nextDouble() * 12;
      final y = rnd.nextDouble() * jag;
      path.lineTo(x.clamp(0, size.width), y);
    }

    path.lineTo(size.width, size.height - jag);

    x = size.width;
    while (x > 0) {
      x -= 12 + rnd.nextDouble() * 12;
      final y = size.height - rnd.nextDouble() * jag;
      path.lineTo(x.clamp(0, size.width), y);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant TornPaperClipper oldClipper) =>
      oldClipper.seed != seed;
}
