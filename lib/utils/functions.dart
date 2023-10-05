import 'package:get_time_ago/get_time_ago.dart';

String formatNumber(String numberString) {
  // Parse the string to an integer
  int number = int.tryParse(numberString) ?? 0;

  if (number >= 1000000000) {
    double result = number / 1000000000;
    return '${result.toStringAsFixed(1)}B';
  } else if (number >= 1000000) {
    double result = number / 1000000;
    return '${result.toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    double result = number / 1000;
    return '${result.toStringAsFixed(1)}K';
  } else {
    return number.toString();
  }
}

class CustomMessages implements Messages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => 'ago';

  @override
  String secsAgo(int seconds) => '$seconds seconds';

  @override
  String minAgo(int minutes) => '1 minute';

  @override
  String minsAgo(int minutes) => '$minutes minutes';

  @override
  String hourAgo(int minutes) => '1 hour';

  @override
  String hoursAgo(int hours) => '$hours hours';

  @override
  String dayAgo(int hours) => '1 day';

  @override
  String daysAgo(int days) => '$days days';

  @override
  String wordSeparator() => ' ';
}

String calculateRelativeTime(String timestamp) {
  GetTimeAgo.setCustomLocaleMessages('en', CustomMessages());
  var convertedTimestamp =
      DateTime.parse(timestamp); // Converting into [DateTime] object
  var result = GetTimeAgo.parse(convertedTimestamp);
  return result;
}