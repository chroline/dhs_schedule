import 'package:dhs_schedule/util/colors.dart';
import 'package:dhs_schedule/util/ctrl/configuration.dart';
import 'package:dhs_schedule/util/ctrl/schedule_manager.dart';
import 'package:dhs_schedule/util/icons.dart';
import 'package:dhs_schedule/util/schemas/period.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'class_list_item.dart';

List<Widget> renderScheduleList(
        {List<Period> periods,
        void Function(String id) onTap,
        BuildContext context}) =>
    periods
        .map((e) => ClassListItem(
              id: e.name,
              name: Provider.of<Configuration>(context).periods[e.name].name,
              color: colors[GetIt.I<Configuration>().periods[e.name].color],
              icon: allIcons[GetIt.I<Configuration>().periods[e.name].icon],
              start: e.start,
              end: e.end,
              onTap: () => onTap(e.name),
              isCurrent: e.name == ScheduleManager.getCurrentClass(periods),
            ))
        .toList();
