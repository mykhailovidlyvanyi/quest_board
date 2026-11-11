import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Заголовок-роздільник блоку дошки: "цвях" + назва + лінія + лічильник.
class SectionTab extends StatelessWidget {
  final String label;
  final int count;

  const SectionTab({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.3, -0.4),
                colors: [
                  Colors.grey.shade300,
                  Colors.grey.shade600,
                  Colors.grey.shade900,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.ptSansNarrow(
              color: AppColors.goldLight,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$count ${_questWord(count)}',
            style: GoogleFonts.ptSans(
              color: AppColors.paper.withOpacity(0.55),
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // Проста українська плюралізація для слова "квест".
  String _questWord(int n) {
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return 'квест';
    if ([2, 3, 4].contains(mod10) && !(mod100 >= 12 && mod100 <= 14)) {
      return 'квести';
    }
    return 'квестів';
  }
}
