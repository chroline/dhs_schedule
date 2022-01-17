import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/organisms/specific_schedule.dart';
import '../../../util/ctrl/configuration.dart';
import '../../../util/ctrl/schedule_manager.dart';

class SpecificDate extends StatelessWidget {
  final DateTime date;

  const SpecificDate({Key? key, required this.date}) : super(key: key);

  AppBar get appBar => AppBar(
        title: Text(
          DateFormat('EEEE, MMMM d').format(date),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Widget get body => ChangeNotifierProvider.value(
      value: GetIt.I<Configuration>(),
      child: Consumer<Configuration>(
        builder: (a, b, c) => GetIt.I
            .get<ScheduleManager>()
            .build(date: date, builder: renderSpecificSchedule),
      ));

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.grey.shade50, appBar: appBar, body: body));
}
