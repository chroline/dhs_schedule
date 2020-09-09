import 'package:dhs_schedule/main.dart';
import 'package:flutter/material.dart';

import 'pages/all_schedules.dart';
import 'pages/specific_date.dart';
import 'pages/today.dart';

class ScheduleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScheduleView();
}

class _ScheduleView extends State<ScheduleView> {
  Widget get appBar => AppBar(
      title: Text(
        "DHS Schedule",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        tooltip: "Open drawer",
        onPressed: () => mainKey.currentState.openDrawer(),
      ),
      actions: <Widget>[
        // action button
        Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.red.shade700)),
          child: new Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.event,
                color: Colors.white,
              ),
              onPressed: () => _openDayPicker(context),
              tooltip: "Jump to date",
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.help,
            color: Colors.white,
          ),
          onPressed: _showHelp,
          tooltip: "Show help",
        )
      ],
      bottom: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.today),
            text: "TODAY",
          ),
          Tab(
            icon: Icon(Icons.calendar_view_day),
            text: "ALL SCHEDULES",
          ),
        ],
        indicatorColor: Color(0xD0FFFFFF),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
      ));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
  }

  void _openDayPicker(BuildContext context) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2021, 6, 30));
    print(date);
    if (date != null)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpecificDate(
                date: date,
              )));
  }

  void _showHelp() => showDialog(
      context: context,
      child: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 20,
            children: [
              Text(
                "View your schedule",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                  "On this view, you can see today's schedule under the TODAY tab, as well as all of your schedules under the ALL SCHEDULES tab."),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            'To view the schedule of a specific date, click the '),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(
                          Icons.event,
                          size: 18,
                        ),
                      ),
                    ),
                    TextSpan(text: ' button to jump to a specific date.'),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}

class _ScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
