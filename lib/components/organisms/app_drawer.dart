import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/views.dart';
import '../atoms/drawer_item.dart';
import '../molecules/drawer_switch.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
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
                        'assets/DHS_Warrior_Logo.png',
                      ),
                    )
                  ],
                ),
              ),
              const DrawerItem(
                view: View.SCHEDULE,
                icon: Icons.schedule,
                text: 'Schedule',
              ),
              const DrawerSwitch(
                icon: Icons.notifications_active,
                text: 'Notifications',
              ),
              const Divider(),
              const DrawerItem(
                view: View.ABOUT,
                icon: Icons.info,
                text: 'About the app',
              ),
              const Expanded(child: SizedBox.shrink()),
              const Divider(height: 1),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child:
                    Text('Go Warriors!', style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      );
}
