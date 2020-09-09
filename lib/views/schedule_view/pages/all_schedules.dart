import 'package:dhs_schedule/components/schedule_list.dart';
import 'package:dhs_schedule/util/ctrl/configuration.dart';
import 'package:dhs_schedule/util/ctrl/schedule_manager.dart';
import 'package:dhs_schedule/views/class_view/class_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AllSchedules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider.value(
        value: GetIt.I<Configuration>(),
        builder: (context, value) => SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: ScheduleManager.schedules.entries
                .map((e) => ExpansionTile(
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      title: Text(
                        e.key.length == 2 ? "${e.key} Day" : e.key,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      children: renderScheduleList(
                          periods: ScheduleManager.schedules[e.key],
                          onTap: (id) => ClassView.showClassView(id, context),
                          context: context),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
