import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/adventurer.dart';
import '../models/quest.dart';
import '../theme/app_colors.dart';
import '../widgets/corkboard_background.dart';
import '../widgets/player_plate.dart';
import '../widgets/quest_card.dart';
import '../widgets/section_tab.dart';

/// Головний екран — дошка оголошень із трьома блоками квестів.
class QuestBoardScreen extends StatefulWidget {
  const QuestBoardScreen({super.key});

  @override
  State<QuestBoardScreen> createState() => _QuestBoardScreenState();
}

class _QuestBoardScreenState extends State<QuestBoardScreen> {
  final Adventurer adventurer = Adventurer(
    adventurerName: 'Мисливець за буднями',
    adventurerLevel: 1,
    adventurerXp: 0,
  );

  final List<Quest> quests = [
    // Щоденні (2)
    Quest(
      id: 'd1',
      name: 'Ковток бадьорості',
      description: 'Випий 2 літри води протягом дня.',
      xp: 15,
      frequency: QuestFrequency.daily,
    ),
    Quest(
      id: 'd2',
      name: 'Прогулянка розвідника',
      description: 'Пройди щонайменше 20 хвилин на свіжому повітрі.',
      xp: 20,
      frequency: QuestFrequency.daily,
    ),
    // Щотижневі (3)
    Quest(
      id: 'w1',
      name: 'Сувій знань',
      description: 'Прочитай 100 сторінок будь-якої книги.',
      xp: 60,
      frequency: QuestFrequency.weekly,
    ),
    Quest(
      id: 'w2',
      name: 'Прибирання лігва',
      description: 'Проведи генеральне прибирання у своїй кімнаті.',
      xp: 45,
      frequency: QuestFrequency.weekly,
    ),
    Quest(
      id: 'w3',
      name: 'Гільдія побратимів',
      description: 'Зустрінься наживо з другом чи родичем.',
      xp: 50,
      frequency: QuestFrequency.weekly,
    ),
    // Щомісячні (5)
    Quest(
      id: 'm1',
      name: 'Огляд у цілителя',
      description: 'Здай плановий аналіз крові або відвідай лікаря.',
      xp: 120,
      frequency: QuestFrequency.monthly,
    ),
    Quest(
      id: 'm2',
      name: 'Скарбниця мандрівника',
      description: 'Відклади певну суму грошей на заощадження.',
      xp: 80,
      frequency: QuestFrequency.monthly,
    ),
    Quest(
      id: 'm3',
      name: 'Нова стежка',
      description: 'Відвідай місце, де ти ще не був жодного разу.',
      xp: 70,
      frequency: QuestFrequency.monthly,
    ),
    Quest(
      id: 'm4',
      name: 'Ремесло майстра',
      description: 'Доведи до кінця маленький творчий або майстровий проєкт.',
      xp: 90,
      frequency: QuestFrequency.monthly,
    ),
    Quest(
      id: 'm5',
      name: 'Порядок у сховищі',
      description:
          'Розбери й приведи до ладу один із своїх цифрових архівів чи шаф.',
      xp: 65,
      frequency: QuestFrequency.monthly,
    ),
  ];

  List<Quest> _byFrequency(QuestFrequency f) =>
      quests.where((q) => q.frequency == f).toList();

  void _toggleQuest(Quest quest) {
    setState(() {
      quest.done = !quest.done;
      adventurer.modifyAdventurerXp(quest.done ? quest.xp : -quest.xp);
    });

    if (quest.done) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.sage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          duration: const Duration(milliseconds: 1400),
          content: Text(
            '+${quest.xp} XP отримано',
            textAlign: TextAlign.center,
            style: GoogleFonts.ptSansNarrow(
              color: AppColors.paper,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSection(QuestFrequency freq) {
    final list = _byFrequency(freq);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTab(label: freq.label, count: list.length),
        for (final quest in list)
          QuestCard(
            quest: quest,
            seed: quest.id.hashCode,
            onToggle: () => _toggleQuest(quest),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CorkboardBackground(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                child: Column(
                  children: [
                    Text(
                      'Дошка квестів',
                      style: GoogleFonts.yesevaOne(
                        fontSize: 26,
                        color: AppColors.paper,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ОГОЛОШЕННЯ ДЛЯ ШУКАЧІВ ПРИГОД',
                      style: GoogleFonts.ptSans(
                        color: AppColors.goldLight.withOpacity(0.85),
                        fontSize: 11,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
              PlayerPlate(adventurer: adventurer),
              _buildSection(QuestFrequency.daily),
              _buildSection(QuestFrequency.weekly),
              _buildSection(QuestFrequency.monthly),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 22),
                child: Text(
                  'РЕАЛЬНІСТЬ — ТВОЄ ПІДЗЕМЕЛЛЯ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ptSans(
                    color: AppColors.paper.withOpacity(0.35),
                    fontSize: 10.5,
                    letterSpacing: 2,
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
