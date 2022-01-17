import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'pages/all_schedules.dart';
import 'pages/specific_date.dart';
import 'pages/today.dart';

class ScheduleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScheduleView();
}

class _ScheduleView extends State<ScheduleView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  AppBar get appBar => AppBar(
      brightness: Brightness.dark,
      title: const Text(
        'DHS Schedule',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        tooltip: 'Open drawer',
        onPressed: () => mainKey.currentState!.openDrawer(),
      ),
      actions: <Widget>[
        // action button
        Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.red.shade700)),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.event,
                color: Colors.white,
              ),
              onPressed: () => _openDayPicker(context),
              tooltip: 'Jump to date',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.help,
            color: Colors.white,
          ),
          onPressed: _showHelp,
          tooltip: 'Show help',
        )
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.today),
            text: 'TODAY',
          ),
          Tab(
            icon: Icon(Icons.calendar_view_day),
            text: 'ALL SCHEDULES',
          ),
        ],
        indicatorColor: Color(0xD0FFFFFF),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
      ));

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: appBar,
        body: ScrollConfiguration(
          behavior: _ScrollBehavior(),
          child: TabBarView(
            children: [Today(), AllSchedules()],
          ),
        ),
      ));

  Future<void> _openDayPicker(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now().isBefore(DateTime(2021, 8, 18))
            ? DateTime(2021, 8, 18)
            : DateTime.now(),
        firstDate: DateTime(2021, 8, 18),
        lastDate: DateTime(2022, 6, 3));
    if (date != null) {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpecificDate(
                date: date,
              )));
    }
  }

  void _showHelp() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                children: [
                  const Text(
                    'View your schedule',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                      "On this view, you can see today's schedule under the "
                      'TODAY tab, as well as all of your schedules under the '
                      'ALL SCHEDULES tab.'),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'To view the schedule of a specific date, '
                                'click the '),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.event,
                              size: 18,
                            ),
                          ),
                        ),
                        TextSpan(text: ' button to jump to a specific date.'),
                      ],
                    ),
                  ),
                  const Text(
                      'To customize the name, color, and icon of a class, tap '
                      'on it.'),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'TIP: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'Add your classroom to the class title to '
                                'easily navigate your day.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}

class _ScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;
}
