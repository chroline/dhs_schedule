import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:yaml/yaml.dart';

import '../schemas/period.dart';

class ScheduleManager {
  double version;
  Map<String, List<Period>> schedules = {};
  Map<DateTime, String> exceptions = {};

  load() async {
    var doc = (await rootBundle.loadString("assets/schedule.yaml"));
    var input = loadYaml(doc);

    version = input['version'];

    (input['schedules'] as Map).forEach((day, value) {
      schedules[day] = (value as List<dynamic>).map((element) {
        var startTime = element['start'].toString().split(":");
        var endTime = element['end'].toString().split(":");
        return Period(
          id: element['name'],
          start: TimeOfDay(hour: int.parse(startTime[0]), minute: int.parse(startTime[1])),
          end: TimeOfDay(hour: int.parse(endTime[0]), minute: int.parse(endTime[1])),
        );
      }).toList();
    });

    (input['exceptions'] as Map).forEach((day, value) => exceptions[DateTime.parse(day)] = value);
  }

  String getScheduleName(DateTime date) {
    try {
      return exceptions.entries
          .firstWhere((v) => v.key.day == date.day && v.key.month == date.month && v.key.year == date.year,
              orElse: null)
          .value;
      // ignore: avoid_catching_errors
    } on Error {
      switch (date.weekday) {
        case 1:
          return "LS";
        case 2:
          return "78";
        case 3:
          return "56";
        case 4:
          return "34";
        case 5:
          return "12";
      }
      return null;
    }
  }

  List<Period> getSchedule(DateTime date) {
    try {
      return schedules[getScheduleName(date)];
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  String getCurrentClass(List<Period> periods) {
    var now = DateTime.now();
    var period = periods.firstWhere((element) {
      return (((now.hour * 60) + now.minute) >= ((element.start.hour * 60) + element.start.minute)) &&
          (((now.hour * 60) + now.minute) <= ((element.end.hour * 60) + element.end.minute));
    }, orElse: () => null);
    if (period == null) return null;
    return period.id;
  }

  Widget build({Widget Function(List<Period> periods, String daySchedule) builder, DateTime date}) {
    if (date == null) date = DateTime.now();
    return builder(schedules[getScheduleName(date)], getScheduleName(date));
  }

  static init() async {
    var manager = ScheduleManager();
    await manager.load();
    GetIt.I.registerSingleton<ScheduleManager>(manager);
  }
}
