import 'package:dhs_schedule/util/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      "assets/DHS_Warrior_Logo.png",
                    ),
                  )
                ],
              ),
            ),
            DrawerItem(
              view: View.SCHEDULE,
              icon: Icons.schedule,
              text: "Schedule",
            ),
            DrawerItem(
              view: View.EVENTS,
              icon: Icons.date_range,
              text: "Upcoming Events",
            ),
            Divider(),
            DrawerItem(
              view: View.ABOUT,
              icon: Icons.info,
              text: "About the app",
            ),
            Expanded(child: SizedBox.shrink()),
            Divider(),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, right: 10, bottom: 15, left: 10),
              child: Text("Go Warriors!", style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }
}
