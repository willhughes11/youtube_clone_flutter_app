import 'package:timeago/timeago.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatNumber(String numberString) {
  // Parse the string to an integer
  int number = int.tryParse(numberString) ?? 0;

  if (number >= 1000000000) {
    double result = number / 1000000000;
    return '${removeTrailingZero(result.toStringAsFixed(1))}B';
  } else if (number >= 1000000) {
    double result = number / 1000000;
    return '${removeTrailingZero(result.toStringAsFixed(1))}M';
  } else if (number >= 1000) {
    double result = number / 1000;
    return '${removeTrailingZero(result.toStringAsFixed(1))}K';
  } else {
    return number.toString();
  }
}

String removeTrailingZero(String str) {
  // Remove trailing ".0" if present
  return str.replaceAll(RegExp(r'\.0$'), '');
}

class CustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => 'from now';
  @override
  String lessThanOneMinute(int seconds) => 'a moment';
  @override
  String aboutAMinute(int minutes) => '1 minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => '1 hour';
  @override
  String hours(int hours) => '$hours hours';
  @override
  String aDay(int hours) => '1 day';
  @override
  String days(int days) => '$days days';
  @override
  String aboutAMonth(int days) => '1 month';
  @override
  String months(int months) => '$months months';
  @override
  String aboutAYear(int year) => '1 year';
  @override
  String years(int years) => '$years years';
  @override
  String wordSeparator() => ' ';
}

String calculateRelativeTime(String timestamp) {
  timeago.setLocaleMessages('en', CustomMessages());
  var convertedTimestamp =
      DateTime.parse(timestamp);
  var result = timeago.format(convertedTimestamp, locale: 'en');
  return result;
}
