import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quest.dart';
import '../theme/app_colors.dart';
import 'torn_paper_clipper.dart';

/// Одна "нотатка" на дошці: назва квесту, опис, воскова печатка з XP,
/// та чекбокс що переключає стан "виконано" зі штампом і перекресленням.
class QuestCard extends StatelessWidget {
  final Quest quest;
  final int seed;
  final VoidCallback onToggle;

  const QuestCard({
    super.key,
    required this.quest,
    required this.seed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final done = quest.done;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
      child: GestureDetector(
        onTap: onToggle,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Тінь під папером
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: TornPaperClipper(seed: seed),
              child: AnimatedOpacity(
                opacity: done ? 0.85 : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18, 16, 16, 14),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.paper, AppColors.paper2],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quest.name,
                                  style: GoogleFonts.yesevaOne(
                                    fontSize: 16,
                                    color: AppColors.ink,
                                    decoration: done
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: AppColors.seal,
                                    decorationThickness: 2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  quest.description,
                                  style: GoogleFonts.ptSans(
                                    fontSize: 12.5,
                                    color: AppColors.inkSoft
                                        .withOpacity(done ? 0.55 : 1),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          _WaxSeal(xp: quest.xp),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _CheckBox(done: done),
                              const SizedBox(width: 7),
                              Text(
                                'Позначити виконаним',
                                style: GoogleFonts.ptSans(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.sage,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                          AnimatedOpacity(
                            opacity: done ? 0.75 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Transform.rotate(
                              angle: -0.14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.seal, width: 2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'ВИКОНАНО',
                                  style: GoogleFonts.yesevaOne(
                                    fontSize: 13,
                                    color: AppColors.seal,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Цвях, що приколює нотатку до дошки
            Positioned(
              top: -9,
              left: 22,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    center: Alignment(-0.3, -0.4),
                    colors: [
                      AppColors.sealLight,
                      AppColors.seal,
                      AppColors.sealDark,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaxSeal extends StatelessWidget {
  final int xp;
  const _WaxSeal({required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.4),
          colors: [
            AppColors.sealLight,
            AppColors.seal,
            AppColors.sealDark,
          ],
          stops: [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$xp',
            style: GoogleFonts.ptSansNarrow(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.paper,
              height: 1,
            ),
          ),
          Text(
            'XP',
            style: GoogleFonts.ptSansNarrow(
              fontSize: 8,
              letterSpacing: 1,
              color: AppColors.paper.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final bool done;
  const _CheckBox({required this.done});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: done ? AppColors.sage : Colors.white.withOpacity(0.3),
        border: Border.all(color: AppColors.sage, width: 2),
        borderRadius: BorderRadius.circular(3),
      ),
      child: done
          ? const Icon(Icons.check, size: 11, color: Colors.white)
          : null,
    );
  }
}
