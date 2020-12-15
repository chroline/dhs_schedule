import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
import 'ctrl/configuration.dart';
import 'ctrl/schedule_manager.dart';
import 'schemas/period.dart';

void initNotifs() async {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentSound: true);
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await GetIt.I
      .get<FlutterLocalNotificationsPlugin>()
      .initialize(initializationSettings);
}

Future<bool> requestIOSNotifPermissions() async {
  return await GetIt.I
      .get<FlutterLocalNotificationsPlugin>()
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

void scheduleNotif(
    {int channel,
    String title,
    String body,
    tz.TZDateTime scheduledDate}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "DHS Schedule App",
      "DHS Schedule App",
      "Alerts when your next class is about to start.",
      icon: "app_icon",
      color: Colors.red,
      priority: Priority.high,
      importance: Importance.high,
      fullScreenIntent: true,
      channelAction: AndroidNotificationChannelAction.update);
  var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: IOSNotificationDetails());
  if (scheduledDate.isAfter(DateTime.now())) {
    await GetIt.I.get<FlutterLocalNotificationsPlugin>().zonedSchedule(
        channel, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}

Future<tz.TZDateTime> scheduleNotifsFromSchedule() async {
  var scheduleManager = GetIt.I.get<ScheduleManager>();
  var channel = 0;

  var currentDay = tz.TZDateTime.now(tz.local);

  tz.TZDateTime lastNotif;

  while (currentDay.weekday <= 5) {
    for (var period in scheduleManager.getSchedule(currentDay) ?? <Period>[]) {
      lastNotif = tz.TZDateTime(tz.local, currentDay.year, currentDay.month,
          currentDay.day, period.start.hour, period.start.minute - 5);

      await scheduleNotif(
          channel: channel,
          title:
              "${GetIt.I<Configuration>().periods[period.id].name} starts in 5 minutes",
          body:
              "${period.id} (${period.start.format(mainKey.currentContext)} — ${period.end.format(mainKey.currentContext)})",
          scheduledDate: lastNotif);
      channel++;
    }
    currentDay = currentDay.add(Duration(days: 1));
  }

  await scheduleNotif(
      channel: channel,
      title: "Enable next week's notifications",
      body:
          "To schedule notifications for next week, open the DHS Schedule App and enable notifications.",
      scheduledDate: tz.TZDateTime(tz.local, currentDay.year, currentDay.month,
          currentDay.day - 1, 4, 0));

  return lastNotif;
}

void cancelNotifs() async =>
    await GetIt.I.get<FlutterLocalNotificationsPlugin>().cancelAll();
