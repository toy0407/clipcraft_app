class DateTimeUtil {
  DateTimeUtil._internal();
  static final DateTimeUtil _instance = DateTimeUtil._internal();
  factory DateTimeUtil() => _instance;

  String formatSecondsToHMS(int? totalSeconds) {
    if (totalSeconds == null || totalSeconds < 0) {
      return '00:00';
    }
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final hoursStr = hours > 0 ? '${hours.toString().padLeft(2, '0')}:' : '';
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = ':${seconds.toString().padLeft(2, '0')}';

    return '$hoursStr$minutesStr$secondsStr';
  }

  String formatRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just Now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      final hrs = difference.inHours;
      return '$hrs ${hrs == 1 ? 'hr' : 'hrs'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}
