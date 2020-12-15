import 'package:dhs_schedule/components/organisms/specific_schedule.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../util/ctrl/configuration.dart';
import '../../../util/ctrl/schedule_manager.dart';

class SpecificDate extends StatefulWidget {
  final DateTime date;

  const SpecificDate({Key key, this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SpecificDate();
}

class _SpecificDate extends State<SpecificDate> {
  Widget get appBar => AppBar(
        title: Text(
          DateFormat('EEEE, MMMM d').format(widget.date),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Widget get body => Container(
        child: ChangeNotifierProvider.value(
            value: GetIt.I<Configuration>(),
            child: Consumer<Configuration>(
              builder: (a, b, c) => GetIt.I
                  .get<ScheduleManager>()
                  .build(date: widget.date, builder: renderSpecificSchedule),
            )),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey.shade50, appBar: appBar, body: body));
  }
}
