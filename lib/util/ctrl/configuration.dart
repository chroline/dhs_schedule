import 'dart:convert';

import 'package:dhs_schedule/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../schemas/period.dart';
import '../schemas/period_configuration.dart';
import 'schedule_manager.dart';

class Configuration extends ChangeNotifier {
  Map<String, PeriodConfiguration> periods = Map();

  static load() async {
    String _config = GetIt.I<SharedPreferences>().getString("config");
    if (_config == null || _config.isEmpty) {
      _config = '''{"periods":{},"version":${ScheduleManager.version}}''';
      await GetIt.I<SharedPreferences>().setString("config", _config);
    }

    var savedConfig = jsonDecode(_config);
    if (savedConfig['version'] != ScheduleManager.version) {
      _config = '''{"periods":{},"version":${ScheduleManager.version}}''';
      await GetIt.I<SharedPreferences>().setString("config", _config);
    }

    Configuration configuration = Configuration();

    ([]
          ..addAll(ScheduleManager.schedules['LS'])
          ..add(Period(name: "Early Bird")))
        .forEach((element) {
      if (savedConfig['periods'][element.name] != null) {
        dynamic period = savedConfig['periods'][element.name];
        configuration.periods[element.name] = PeriodConfiguration(
            name: period['name'], color: period['color'], icon: period['icon']);
      } else
        configuration.periods[element.name] = PeriodConfiguration(
            name: element.name, color: 'blueGrey', icon: 'English');
    });

    GetIt.I.registerSingleton<Configuration>(configuration);
  }

  void _save() {
    var config = {
      "periods": periods.map((key, value) => MapEntry(key, value.toJson())),
      "version": ScheduleManager.version
    };
    GetIt.I<SharedPreferences>().setString("config", jsonEncode(config));
  }

  void update(String key, {String name, MaterialColor color, String icon}) {
    if (name != null && name.isNotEmpty) periods[key].name = name;
    if (color != null)
      periods[key].color =
          colors.entries.firstWhere((e) => e.value == color).key;
    if (icon != null && icon.isNotEmpty) periods[key].icon = icon;
    _save();
    notifyListeners();
  }
}
