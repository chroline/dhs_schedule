import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'components/organisms/app_drawer.dart';
import 'util/ctrl/configuration.dart';
import 'util/ctrl/navigation_controller.dart';
import 'util/ctrl/schedule_manager.dart';
import 'util/views.dart';
import 'views/about_view.dart';
import 'views/loading_view.dart';
import 'views/schedule_view/schedule_view.dart';

GlobalKey<ScaffoldState> mainKey = GlobalKey();

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final timeZoneName = await MethodChannel('colegaw.in/dhs_schedule')
      .invokeMethod('getTimeZoneName');
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _configureLocalTimeZone();

  GetIt.I.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
  NavigationController.init();
  runApp(App());

  var prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  await ScheduleManager.init();
  await Configuration.init();

  GetIt.I<NavigationController>().update(View.SCHEDULE);
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'DHS Schedule',
      theme: ThemeData(
          primarySwatch: Colors.red, primaryColor: Colors.red.shade700),
      home: ChangeNotifierProvider.value(
        value: GetIt.I<NavigationController>(),
        builder: (context, snapshot) {
          if (Provider.of<NavigationController>(context).view != null) {
            Widget view;
            switch (Provider.of<NavigationController>(context).view) {
              case View.SCHEDULE:
                view = ScheduleView();
                break;
              case View.ABOUT:
                view = AboutView();
                break;
            }
            return Material(
                type: MaterialType.transparency,
                child: Scaffold(
                  key: mainKey,
                  drawer: AppDrawer(),
                  body: view,
                ));
          } else {
            return LoadingView();
          }
        },
      ),
    );
  }
}
