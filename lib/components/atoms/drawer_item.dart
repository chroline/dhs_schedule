import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/ctrl/navigation_controller.dart';
import '../../util/views.dart';

class DrawerItem extends StatefulWidget {
  final View view;
  final IconData icon;
  final String text;

  const DrawerItem(
      {Key? key, required this.view, required this.icon, required this.text})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerItem();
}

class _DrawerItem extends State<DrawerItem> {
  Color get foregroundColor {
    if (Provider.of<NavigationController>(context).view == widget.view) {
      return Colors.red.shade700;
    }
    return Colors.grey.shade900;
  }

  Color get backgroundColor {
    if (Provider.of<NavigationController>(context).view == widget.view) {
      return Colors.red.shade50;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            splashColor: Colors.red.withAlpha(100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: foregroundColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 17,
                        color: foregroundColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            onTap: () {
              Provider.of<NavigationController>(context, listen: false)
                  .update(widget.view);
              Navigator.pop(context);
            },
          ),
        ),
      );
}
