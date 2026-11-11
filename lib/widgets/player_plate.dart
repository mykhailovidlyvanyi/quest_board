import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/adventurer.dart';
import '../theme/app_colors.dart';

/// Латунна табличка гравця: ранг, ім'я та шкала досвіду до наступного рівня.
class PlayerPlate extends StatelessWidget {
  final Adventurer adventurer;

  const PlayerPlate({super.key, required this.adventurer});

  @override
  Widget build(BuildContext context) {
    final progress = (adventurer.adventurerXp /
            adventurer.adventurerXpToNextLevel)
        .clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.woodPlate,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.3, -0.4),
                colors: [
                  AppColors.goldLight,
                  AppColors.gold,
                  const Color(0xFF7A5620),
                ],
              ),
              border: Border.all(color: const Color(0xFF3A2712), width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              '${adventurer.adventurerLevel}',
              style: GoogleFonts.yesevaOne(
                fontSize: 18,
                color: const Color(0xFF3A2712),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adventurer.adventurerName,
                  style: GoogleFonts.ptSans(
                    color: AppColors.paper,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 8,
                    color: const Color(0xFF231708),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.sageLight, AppColors.sage],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${adventurer.adventurerXp} / ${adventurer.adventurerXpToNextLevel} XP до ${adventurer.adventurerLevel + 1} рівня',
                  style: GoogleFonts.ptSansNarrow(
                    color: AppColors.goldLight,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
