/// Гравець ("шукач пригод") — окрема сутність зі своїм рівнем та досвідом,
/// відокремлена від логіки самої дошки квестів.
class Adventurer {
  /// Досвід, потрібний для переходу з 1 на 2 рівень.
  static const int baseXp = 100;

  /// На скільки зростає поріг досвіду з кожним наступним рівнем.
  static const int increment = 50;

  String adventurerName;
  int adventurerLevel;
  int adventurerXp;

  /// Сумарний досвід, зароблений за весь час (не обнуляється при переході
  /// на новий рівень, на відміну від [adventurerXp]).
  int adventurerTotalXp;

  Adventurer({
    required this.adventurerName,
    this.adventurerLevel = 1,
    this.adventurerXp = 0,
    this.adventurerTotalXp = 0,
  });

  /// Лінійна прогресія: adventurerXpToNextLevel = baseXp + increment * (adventurerLevel - 1).
  int get adventurerXpToNextLevel =>
      baseXp + increment * (adventurerLevel - 1);

  /// Додає (або віднімає, якщо amount від'ємний) досвід.
  /// Автоматично підвищує чи знижує рівень, коли adventurerXp
  /// перетинає поріг adventurerXpToNextLevel в той чи інший бік.
  void modifyAdventurerXp(int amount) {
    adventurerXp += amount;
    adventurerTotalXp = (adventurerTotalXp + amount).clamp(0, 1 << 62);

    while (adventurerXp >= adventurerXpToNextLevel) {
      adventurerXp -= adventurerXpToNextLevel;
      adventurerLevel += 1;
    }

    while (adventurerXp < 0) {
      if (adventurerLevel <= 1) {
        adventurerXp = 0;
        break;
      }
      adventurerLevel -= 1;
      adventurerXp += adventurerXpToNextLevel;
    }
  }
}
