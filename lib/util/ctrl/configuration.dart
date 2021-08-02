import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../schemas/period_configuration.dart';
import 'notifications.dart';
import 'schedule_manager.dart';

class Configuration extends ChangeNotifier {
  static late ScheduleManager scheduleManager;
  static late BuildContext context;

  Map<String, PeriodConfiguration> periods = {};
  bool notifs = false;
  DateTime? lastNotif;

  static Future<void> init() async {
    scheduleManager = GetIt.I.get<ScheduleManager>();

    var _config = GetIt.I<SharedPreferences>().getString('config');
    Future<void> resetConfig() async {
      _config =
          '''{"periods":{},"version":${scheduleManager.version},"notifs":false,"lastNotif":null}''';
      await GetIt.I<SharedPreferences>().setString('config', _config!);
    }

    if (_config == null || _config!.isEmpty) {
      await resetConfig();
    }

    final savedConfig = jsonDecode(_config!);
    if (savedConfig['version'] != scheduleManager.version) {
      await resetConfig();
    }

    final configuration = Configuration();

    configuration.lastNotif = savedConfig['lastNotif'] == null
        ? null
        : DateTime.parse(savedConfig['notifs']);
    if ((configuration.lastNotif ?? DateTime.now()).compareTo(DateTime.now()) <
        0) {
      configuration.notifs = false;
    } else {
      configuration.notifs = savedConfig['notifs'] == true;
    }

    void addToConfiguration(String element) {
      if (savedConfig['periods'][element] != null) {
        final dynamic period = savedConfig['periods'][element];
        configuration.periods[element] = PeriodConfiguration(
            name: period['name'], color: period['color'], icon: period['icon']);
      } else {
        configuration.periods[element] = PeriodConfiguration(
            name: element, color: 'blueGrey', icon: 'English');
      }
    }

    (scheduleManager.classes).forEach(addToConfiguration);

    await configuration._save();
    GetIt.I.registerSingleton<Configuration>(configuration);
  }

  Future<void> _save() async {
    final config = {
      'periods': periods.map((key, value) => MapEntry(key, value.toJson())),
      'version': scheduleManager.version,
      'notifs': notifs,
      'lastNotif': lastNotif?.toIso8601String()
    };
    await GetIt.I<SharedPreferences>().setString('config', jsonEncode(config));
  }

  void updatePeriod(String key,
      {String? name, MaterialColor? color, String? icon}) {
    if (name != null && name.isNotEmpty) periods[key]!.name = name;
    if (color != null) {
      periods[key]!.color =
          colors.entries.firstWhere((e) => e.value == color).key;
    }
    if (icon != null && icon.isNotEmpty) periods[key]!.icon = icon;
    _save();
    notifyListeners();
  }

  Future<void> toggleNotifs(BuildContext context) async {
    notifs = !notifs;
    if (notifs) {
      await initNotifs();
      if (Platform.isIOS) {
        final allowed = await requestIOSNotifPermissions();
        if (!allowed) {
          notifs = false;
        }
      }

      // ignore: unawaited_futures
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        const Text(
                          "Scheduling this week's notifications...",
                          style: TextStyle(
                              fontSize: 17.5, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              ),
          barrierDismissible: false);
      await scheduleNotifsFromSchedule();
      Navigator.pop(context);
    } else {
      await cancelNotifs();
    }
    await _save();
    notifyListeners();
  }
}
