import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../components/organisms/specific_schedule.dart';
import '../../../util/ctrl/configuration.dart';
import '../../../util/ctrl/schedule_manager.dart';

class Today extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Today();
}

class _Today extends State<Today> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: GetIt.I<Configuration>(),
        child: Consumer<Configuration>(
          builder: (_, __, ___) =>
              GetIt.I<ScheduleManager>().build(builder: renderSpecificSchedule),
        ),
      );
}
