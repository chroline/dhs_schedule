import 'package:dhs_schedule/components/schedule_list.dart';
import 'package:dhs_schedule/util/ctrl/configuration.dart';
import 'package:dhs_schedule/util/ctrl/schedule_manager.dart';
import 'package:dhs_schedule/views/class_view/class_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'no_school.dart';

class Today extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Today();
}

class _Today extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider.value(
        value: GetIt.I<Configuration>(),
        builder: (context, value) => ScheduleManager.build(
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
  }
}
