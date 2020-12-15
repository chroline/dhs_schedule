import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/views.dart';
import '../atoms/drawer_item.dart';
import '../molecules/drawer_switch.dart';

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
            DrawerSwitch(
              icon: Icons.notifications_active,
              text: "Notifications",
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
