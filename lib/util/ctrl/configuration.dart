import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../notifications.dart';
import '../schemas/period.dart';
import '../schemas/period_configuration.dart';
import 'schedule_manager.dart';

class Configuration extends ChangeNotifier {
  static ScheduleManager scheduleManager;
  static BuildContext context;

  Map<String, PeriodConfiguration> periods = {};
  bool notifs = false;
  DateTime lastNotif;

  static init() async {
    scheduleManager = GetIt.I.get<ScheduleManager>();

    var _config = GetIt.I<SharedPreferences>().getString("config");
    void resetConfig() async {
      _config =
          '''{"periods":{},"version":${scheduleManager.version},"notifs":false,"lastNotif":null}''';
      await GetIt.I<SharedPreferences>().setString("config", _config);
    }

    if (_config == null || _config.isEmpty) {
      await resetConfig();
    }

    var savedConfig = jsonDecode(_config);
    if (savedConfig['version'] != scheduleManager.version) {
      print("nope");
      await resetConfig();
    }

    var configuration = Configuration();

    configuration.lastNotif = savedConfig['lastNotif'] == null
        ? null
        : DateTime.parse(savedConfig['notifs']);
    if ((configuration.lastNotif ?? DateTime.now()).compareTo(DateTime.now()) <
        0) {
      configuration.notifs = false;
    } else {
      configuration.notifs = savedConfig['notifs'] == true;
    }

    void addToConfiguration(dynamic element) {
      if (savedConfig['periods'][element.id] != null) {
        dynamic period = savedConfig['periods'][element.id];
        configuration.periods[element.id] = PeriodConfiguration(
            name: period['name'], color: period['color'], icon: period['icon']);
      } else {
        configuration.periods[element.id] = PeriodConfiguration(
            name: element.id, color: 'blueGrey', icon: 'English');
      }
    }

    (scheduleManager.schedules['LS'].toList()..add(Period(id: "Early Bird")))
        .forEach(addToConfiguration);

    await configuration._save();
    GetIt.I.registerSingleton<Configuration>(configuration);
  }

  void _save() async {
    var config = {
      "periods": periods.map((key, value) => MapEntry(key, value.toJson())),
      "version": scheduleManager.version,
      "notifs": notifs,
      "lastNotif": lastNotif?.toIso8601String()
    };
    await GetIt.I<SharedPreferences>().setString("config", jsonEncode(config));
  }

  void updatePeriod(String key,
      {String name, MaterialColor color, String icon}) {
    if (name != null && name.isNotEmpty) periods[key].name = name;
    if (color != null) {
      periods[key].color =
          colors.entries.firstWhere((e) => e.value == color).key;
    }
    if (icon != null && icon.isNotEmpty) periods[key].icon = icon;
    _save();
    notifyListeners();
  }

  void toggleNotifs(BuildContext context) async {
    notifs = !notifs;
    if (notifs) {
      initNotifs();
      if (Platform.isIOS) {
        var allowed = await requestIOSNotifPermissions();
        if (!allowed) {
          notifs = false;
        }
      }

      await scheduleNotifsFromSchedule();
    } else {
      await cancelNotifs();
    }
    await _save();
    notifyListeners();
  }
}
