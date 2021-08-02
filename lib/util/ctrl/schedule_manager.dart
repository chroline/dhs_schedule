import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:yaml/yaml.dart';

import '../schemas/period.dart';

class ScheduleManager {
  late double version;
  List<String> classes = [];
  Map<String, List<Period>> schedules = {};
  Map<DateTime, String?> exceptions = {};

  Future<void> load() async {
    final doc = await rootBundle.loadString('assets/schedule.yaml');
    final input = loadYaml(doc);

    version = input['version'];

    classes = (input['classes'] as YamlList).toList().cast<String>();

    (input['schedules'] as Map).forEach((day, value) {
      schedules[day] = (value as List<dynamic>).map((element) {
        final startTime = element['start'].toString().split(':');
        final endTime = element['end'].toString().split(':');
        return Period(
          id: element['name'],
          start: TimeOfDay(
              hour: int.parse(startTime[0]), minute: int.parse(startTime[1])),
          end: TimeOfDay(
              hour: int.parse(endTime[0]), minute: int.parse(endTime[1])),
        );
      }).toList();
    });

    (input['exceptions'] as Map).forEach((day, value) {
      exceptions[DateTime.parse(day)] = value;
    });
  }

  String? getScheduleName(DateTime date) {
    try {
      return exceptions.entries
          .firstWhere((v) =>
              v.key.day == date.day &&
              v.key.month == date.month &&
              v.key.year == date.year)
          .value;
    } catch (_) {
      switch (date.weekday) {
        case 1:
          return 'LS';
        case 2:
          return '78';
        case 3:
          return '56';
        case 4:
          return '34';
        case 5:
          return '12';
      }
      return null;
    }
  }

  List<Period>? getSchedule(DateTime date) {
    try {
      return schedules[getScheduleName(date)]!;
    } catch (_) {
      return null;
    }
  }

  String? getCurrentClass(List<Period> periods) {
    final now = DateTime.now();
    try {
      final period = periods.firstWhere((element) =>
          (((now.hour * 60) + now.minute) >=
              ((element.start.hour * 60) + element.start.minute)) &&
          (((now.hour * 60) + now.minute) <=
              ((element.end.hour * 60) + element.end.minute)));
      return period.id;
    } catch (_) {
      return null;
    }
  }

  Widget build(
      {required Widget Function(List<Period>? periods, String? daySchedule)
          builder,
      DateTime? date}) {
    date ??= DateTime.now();
    return builder(schedules[getScheduleName(date)], getScheduleName(date));
  }

  static Future<void> init() async {
    final manager = ScheduleManager();
    await manager.load();
    GetIt.I.registerSingleton<ScheduleManager>(manager);
  }
}
