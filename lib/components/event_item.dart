import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dhs_schedule/util/schemas/event_schema.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final EventSchema event;
  final bool showDate;

  const EventItem({Key key, this.event, this.showDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 72,
                  child: showDate
                      ? Column(
                          children: [
                            Text(
                              DateFormat("EE").format(event.time).toUpperCase(),
                              style: TextStyle(fontSize: 12, letterSpacing: 1),
                            ),
                            Text(
                              "${event.time.day}",
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Material(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    splashColor: Colors.red.withAlpha(100),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          event.desc.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    event.desc,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                                "${DateFormat.jm().format(event.time)} @ ${event.location}"),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Add2Calendar.addEvent2Cal(Event(
                          title: event.name,
                          description: event.desc,
                          location: event.location,
                          timeZone: "GMT-5",
                          startDate: event.time,
                          endDate: event.time.add(Duration(hours: 1))));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
