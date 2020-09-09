import 'package:dhs_schedule/components/app_drawer.dart';
import 'package:dhs_schedule/util/ctrl/navigation_controller.dart';
import 'package:dhs_schedule/util/views.dart';
import 'package:dhs_schedule/views/about_view.dart';
import 'package:dhs_schedule/views/events_view.dart';
import 'package:dhs_schedule/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'util/ctrl/configuration.dart';
import 'util/ctrl/schedule_manager.dart';
import 'views/schedule_view/schedule_view.dart';

GlobalKey<ScaffoldState> mainKey = GlobalKey();

void main() async {
  NavigationController.load();
  runApp(App());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  await ScheduleManager.load();
  await Configuration.load();

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
      title: 'DHS Schedule App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        primaryColor: Colors.red.shade700,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider.value(
        value: GetIt.I<NavigationController>(),
        builder: (context, snapshot) {
          if (Provider.of<NavigationController>(context).view != null) {
            Widget view;
            switch (Provider.of<NavigationController>(context).view) {
              case View.SCHEDULE:
                view = ScheduleView();
                break;
              case View.EVENTS:
                view = EventsView();
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
