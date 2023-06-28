extension StringExtension on String {
  String convertToTitleCase() {
    if (trim().isEmpty) {
      return '';
    }
    final List<String> words = split(' ');
    final capitalizedWords = words.map((word) {
      if (word.trim().length > 2) {
        if (word.trim().isNotEmpty) {
          final String firstLetter = word.trim().substring(0, 1).toUpperCase();
          final String remainingLetters = word.trim().substring(1);

          return '$firstLetter$remainingLetters';
        }
        return '';
      } else {
        return word;
      }
    });
    return capitalizedWords.join(' ');
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}