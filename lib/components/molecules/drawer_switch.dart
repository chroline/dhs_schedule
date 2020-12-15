import 'package:dhs_schedule/util/ctrl/configuration.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DrawerSwitch extends StatefulWidget {
  final IconData icon;
  final String text;

  const DrawerSwitch({Key key, this.icon, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerItem();
}

class _DrawerItem extends State<DrawerSwitch> {
  final Configuration configuration = GetIt.I<Configuration>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          splashColor: Colors.red.withAlpha(100),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                ChangeNotifierProvider.value(
                  value: GetIt.I.get<Configuration>(),
                  child: Consumer<Configuration>(
                    builder: (a, b, c) => Switch(
                      value: GetIt.I<Configuration>().notifs,
                      onChanged: (value) =>
                          GetIt.I<Configuration>().toggleNotifs(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
