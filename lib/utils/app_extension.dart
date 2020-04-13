extension DateTimeExtension on DateTime {
  bool isTheSameDay(DateTime dateTime) {
    if (this.day == dateTime.day && this.month == dateTime.month && this.year == dateTime.year) {
      return true;
    }
    return false;
  }
}

extension StringExtension on String {
  String firstLetterUppercase() {
    return this[0].toUpperCase() + this.substring(1, this.length);
  }
}
