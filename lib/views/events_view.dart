import 'package:dhs_schedule/components/event_item.dart';
import 'package:dhs_schedule/main.dart';
import 'package:dhs_schedule/util/credentials.dart';
import 'package:dhs_schedule/util/schemas/event_schema.dart';
import 'package:dhs_schedule/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

class EventsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventsView();
}

class _EventsView extends State<EventsView> {
  Widget get appBar => AppBar(
          backgroundColor: Colors.red.shade700,
          title: Text(
            "Upcoming Events",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => mainKey.currentState.openDrawer(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
              ),
              onPressed: _showHelp,
              tooltip: "Show help",
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: appBar,
      body: FutureBuilder(
        future: _loadEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int curDay;
            int curMonth;
            int curYear;
            List<Widget> widgets = List();
            (snapshot.data as List<EventSchema>).forEach((e) {
              if (e.time.year != curYear || e.time.month != curMonth) {
                widgets.add(
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 72, bottom: 10),
                    child: Text(
                      "${DateFormat("MMMM").format(e.time)} '${e.time.year - 2000}",
                      style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                );
              }

              widgets.add(EventItem(
                event: e,
                showDate: !(curDay == e.time.day &&
                    curMonth == e.time.month &&
                    curYear == e.time.year),
              ));

              curDay = e.time.day;
              curMonth = e.time.month;
              curYear = e.time.year;
            });
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              ),
            );
          } else {
            return LoadingView();
          }
        },
      ),
    );
  }

  Future<List<EventSchema>> _loadEvents() async => GSheets(credentials)
      .spreadsheet("1yuA6_8tLDe0z_NPTRAzBg7cCGI3HYoylzIOFeFTbzQ0")
      .then((ss) =>
          ss.worksheetByTitle('Form Responses').values.allRows(fromRow: 2))
      .then((sheet) => sheet
          .map((element) => EventSchema(
              name: element[1],
              desc: element[2],
              time: _timestampToDateTime(element[3])
                  .add(_timestampToDuration(element[4])),
              location: element[5]))
          .toList());

  void _showHelp() => showDialog(
      context: context,
      child: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 20,
            children: [
              Text(
                "Find upcoming events",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                  "Interested in supporting DHS clubs and athletics? You can find upcoming school activities and events on this view. See when and where each activity is underneath the title, and tap on it to save to your calendar."),
            ],
          ),
        ),
      ));
}

DateTime _timestampToDateTime(String timestamp) => DateTime(1899, 12, 29, 23)
    .add(Duration(days: double.parse(timestamp).toInt()));

Duration _timestampToDuration(String timestamp) =>
    Duration(seconds: (double.parse(timestamp) * 86400).round());
