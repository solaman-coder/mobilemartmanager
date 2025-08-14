enum DateRangeType { today, week, month, year }

bool isInSelectedRange(DateTime date, DateRangeType rangeType) {
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);

  switch (rangeType) {
    case DateRangeType.today:
      return date.isAfter(startOfToday);
    case DateRangeType.week:
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return date.isAfter(
          DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day));
    case DateRangeType.month:
      return date.month == now.month && date.year == now.year;
    case DateRangeType.year:
      return date.year == now.year;
  }
}
