import 'package:dhs_schedule/util/icons.dart';
import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {
  final Function(MapEntry<dynamic, dynamic>) onTap;

  const IconPicker({Key key, this.onTap}) : super(key: key);

  Widget icon(MapEntry<dynamic, dynamic> k) => InkWell(
        onTap: () => onTap(k),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2, right: 20, left: 20),
                  child: Icon(k.value),
                ),
                Expanded(
                  child: Text(
                    "${k.key}",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150, maxHeight: 450),
        child: ListView(
            padding: EdgeInsets.symmetric(vertical: 5),
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: []
              ..addAll(icons['math'].entries.map(icon))
              ..add(Divider())
              ..addAll(icons['science'].entries.map(icon))
              ..add(Divider())
              ..addAll(icons['language'].entries.map(icon))
              ..add(Divider())
              ..addAll(icons['appliedArts'].entries.map(icon))
              ..add(Divider())
              ..addAll(icons['gym'].entries.map(icon))
              ..add(Divider())
              ..addAll(icons['homeroom'].entries.map(icon))));
  }
}
