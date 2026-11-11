/// Періодичність квесту — визначає, у якому блоці дошки він з'являється.
enum QuestFrequency { daily, weekly, monthly }

extension QuestFrequencyLabel on QuestFrequency {
  String get label {
    switch (this) {
      case QuestFrequency.daily:
        return 'Щоденні';
      case QuestFrequency.weekly:
        return 'Щотижневі';
      case QuestFrequency.monthly:
        return 'Щомісячні';
    }
  }
}

/// Один квест на дошці: назва, опис, вартість у досвіді та статус виконання.
/// Кількість квестів у кожній категорії — просто довжина списку,
/// тож 2 щоденних / 3 щотижневих / 5 щомісячних — лише стартові дані,
/// а не жорстке обмеження верстки.
class Quest {
  final String id;
  final String name;
  final String description;
  final int xp;
  final QuestFrequency frequency;
  bool done;

  Quest({
    required this.id,
    required this.name,
    required this.description,
    required this.xp,
    required this.frequency,
    this.done = false,
  });
}
