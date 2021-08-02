import 'package:flutter/material.dart';

import '../../util/schemas/period.dart';
import '../../views/class_view/class_view.dart';
import '../../views/schedule_view/pages/no_school.dart';
import 'schedule_list.dart';

Widget renderSpecificSchedule(List<Period>? periods, String? daySchedule) =>
    daySchedule == null
        ? NoSchool()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: renderScheduleList(
                periods: periods!,
                onTap: ClassView.showClassView,
              ),
            ),
          );
