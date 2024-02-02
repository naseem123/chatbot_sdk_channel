import 'package:timeago/timeago.dart';

extension DateTimeExtension on DateTime {
  String get timeAgo => format(this);
}
