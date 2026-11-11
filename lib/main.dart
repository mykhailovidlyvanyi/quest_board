import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/quest_board_screen.dart';

void main() {
  runApp(const QuestBoardApp());
}

class QuestBoardApp extends StatelessWidget {
  const QuestBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дошка квестів',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.woodDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.dark,
        ),
      ),
      // Локаль інтерфейсу — українська (текст у застосунку вже україномовний,
      // цей рядок потрібен лише для системних віджетів на кшталт дат/локалізації,
      // якщо їх додати пізніше).
      home: const QuestBoardScreen(),
    );
  }
}
