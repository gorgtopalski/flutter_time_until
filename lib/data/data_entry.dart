import 'package:flutter/widgets.dart';
import 'package:flutter_time_until/time/time_format.dart';
import 'package:hive/hive.dart';

part 'data_entry.g.dart';

@HiveType(typeId: 0)
class DateEntry extends HiveObject {
  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  String? description;

  @HiveField(2)
  IconData? icon;

  DateEntry(this.description, this.date);

  DateEntry.withIcon(this.description, this.date, this.icon);

  Duration get timeRemaining => date.difference(DateTime.now());

  String get timeRemainingString =>
      TimeFormat.formatDuration(this.timeRemaining);

  String get timeSelectedString => TimeFormat.formatDate(this.date);
}
