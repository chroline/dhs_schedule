import 'package:dhs_schedule/components/schedule_list.dart';
import 'package:dhs_schedule/util/ctrl/configuration.dart';
import 'package:dhs_schedule/util/ctrl/schedule_manager.dart';
import 'package:dhs_schedule/views/class_view/class_view.dart';
import 'package:dhs_schedule/views/schedule_view/pages/no_school.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          builder: (context, value) => ScheduleManager.build(
              date: widget.date,
              builder: (periods, daySchedule) => daySchedule == null
                  ? NoSchool()
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: renderScheduleList(
                            periods: periods,
                            onTap: (id) => ClassView.showClassView(id, context),
                            context: context),
                      ),
                    )),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey.shade50, appBar: appBar, body: body));
  }
}
