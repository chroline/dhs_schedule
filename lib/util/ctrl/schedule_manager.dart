import 'package:dhs_schedule/util/schemas/period.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class ScheduleManager {
  static double version;
  static Map<String, List<Period>> schedules = Map();
  static Map<DateTime, String> exceptions = Map();

  static load() async {
    String doc = (await rootBundle.loadString("assets/schedule.yaml"));
    var input = loadYaml(doc);

    version = input['version'];

    (input['schedules'] as Map).forEach((day, value) {
      schedules["$day"] = [];
      value.forEach((element) {
        List<String> startTime = element['start'].toString().split(":");
        List<String> endTime = element['end'].toString().split(":");
        schedules["$day"].add(Period(
          name: element['name'],
          start: TimeOfDay(
              hour: int.parse(startTime[0]), minute: int.parse(startTime[1])),
          end: TimeOfDay(
              hour: int.parse(endTime[0]), minute: int.parse(endTime[1])),
        ));
      });
    });

    (input['exceptions'] as Map)
        .forEach((day, value) => exceptions[DateTime.parse(day)] = value);
  }

  static String getDaySchedule(DateTime date) {
    try {
      return exceptions.entries
          .firstWhere(
              (v) =>
                  v.key.day == date.day &&
                  v.key.month == date.month &&
                  v.key.year == date.year,
              orElse: null)
          .value;
    } catch (e) {
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

  static String getCurrentClass(List<Period> periods) {
    DateTime now = DateTime.now();
    Period period = periods.firstWhere((element) {
      return (((now.hour * 60) + now.minute) >=
              ((element.start.hour * 60) + element.start.minute)) &&
          (((now.hour * 60) + now.minute) <=
              ((element.end.hour * 60) + element.end.minute));
    }, orElse: () => null);
    if (period == null) return null;
    return period.name;
  }

  static Widget build(
      {Widget Function(List<Period> periods, String daySchedule) builder,
      DateTime date}) {
    if (date == null) date = DateTime.now();
    return builder(schedules[getDaySchedule(date)], getDaySchedule(date));
  }
}
