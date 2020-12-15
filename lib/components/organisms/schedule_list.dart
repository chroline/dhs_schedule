import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../util/colors.dart';
import '../../util/ctrl/configuration.dart';
import '../../util/ctrl/schedule_manager.dart';
import '../../util/icons.dart';
import '../../util/schemas/period.dart';
import '../molecules/class_list_item.dart';

List<Widget> renderScheduleList(
        {List<Period> periods,
        void Function(String id) onTap,
        BuildContext context}) =>
    periods
        .map((e) => ClassListItem(
              id: e.id,
              name: GetIt.I<Configuration>().periods[e.id].name,
              color: colors[GetIt.I<Configuration>().periods[e.id].color],
              icon: allIcons[GetIt.I<Configuration>().periods[e.id].icon],
              start: e.start,
              end: e.end,
              onTap: () => onTap(e.id),
              isCurrent: e.id ==
                  GetIt.I.get<ScheduleManager>().getCurrentClass(periods),
            ))
        .toList();
