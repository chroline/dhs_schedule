import 'package:flutter/material.dart';

class ClassListItem extends StatefulWidget {
  final String name;
  final String id;
  final MaterialColor color;
  final IconData icon;
  final TimeOfDay start;
  final TimeOfDay end;

  final bool isCurrent;
  final void Function() onTap;

  ClassListItem(
      {Key? key,
      required this.name,
      required this.color,
      required this.icon,
      required this.onTap,
      required this.id,
      required this.start,
      required this.end,
      required this.isCurrent})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClassListItem();
}

class _ClassListItem extends State<ClassListItem> {
  late bool isCurrent;

  @override
  void initState() {
    super.initState();
    isCurrent = widget.isCurrent;
  }

  Color get subtitleColor {
    if (isCurrent) {
      return Colors.white.withOpacity(0.6);
    }
    return widget.color.shade900.withAlpha(100);
  }

  Color get titleColor {
    if (isCurrent) {
      return Colors.white.withOpacity(0.8);
    }
    return Colors.black;
  }

  Color get indicatorColor {
    if (isCurrent) {
      return widget.color.shade400;
    }
    return widget.color.shade700;
  }

  Color get shadowColor {
    if (isCurrent) {
      return widget.color.shade800.withOpacity(0.8);
    }
    return widget.color.shade700.withOpacity(0.5);
  }

  Color get iconColor {
    if (isCurrent) {
      return Colors.white.withOpacity(0.75);
    }
    return widget.color.shade500;
  }

  Color get timeColor {
    if (isCurrent) {
      return Colors.white.withOpacity(0.6);
    }
    return Colors.grey.shade500;
  }

  Color get separatorColor {
    if (isCurrent) {
      return widget.color.shade700;
    }
    return Colors.grey.shade900.withAlpha(50);
  }

  @override
  Widget build(BuildContext context) => ClipRect(
        child: Container(
          color: isCurrent ? widget.color : null,
          child: InkWell(
            onTap: widget.onTap,
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Container(
                      width: 3,
                      decoration:
                          BoxDecoration(color: indicatorColor, boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 8.0,
                          spreadRadius: -0.1,
                          offset: const Offset(
                            3.0,
                            0.0,
                          ),
                        ),
                      ])),
                  Column(children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Icon(
                              widget.icon,
                              color: iconColor,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.id.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: subtitleColor,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2),
                                  ),
                                  Text(
                                    widget.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: titleColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            // ignore: lines_longer_than_80_chars
                            child: Text(
                              '${widget.start.format(context)} — '
                              '${widget.end.format(context)}',
                              style: TextStyle(fontSize: 12, color: timeColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(56, 0, 0),
                      height: 1,
                      width: double.infinity,
                      color: separatorColor,
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),
      );
}
