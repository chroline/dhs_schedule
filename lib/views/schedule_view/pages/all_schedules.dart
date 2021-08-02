import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../components/organisms/schedule_list.dart';
import '../../../util/ctrl/configuration.dart';
import '../../../util/ctrl/schedule_manager.dart';
import '../../class_view/class_view.dart';

class AllSchedules extends StatelessWidget {
  final ScheduleManager scheduleManager = GetIt.I.get<ScheduleManager>();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: GetIt.I<Configuration>(),
        child: Consumer<Configuration>(
          builder: (a, b, c) => SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: scheduleManager.schedules.entries
                  .map((e) => Container(
                        constraints: const BoxConstraints(maxWidth: 512),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          title: Text(
                            e.key.length <= 3 ? '${e.key} Day' : e.key,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          children: renderScheduleList(
                            periods: scheduleManager.schedules[e.key]!,
                            onTap: ClassView.showClassView,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}
