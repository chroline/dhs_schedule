import 'package:flutter/material.dart';

import '../../util/colors.dart';

class ColorPicker extends StatelessWidget {
  final Function(String) onTap;

  const ColorPicker({Key key, this.onTap}) : super(key: key);

  Widget color(MapEntry<dynamic, dynamic> k) => Padding(
        padding: EdgeInsets.all(5),
        child: Material(
          color: k.value,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => onTap(k.key),
            splashColor: (k.value as MaterialColor).shade200,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constrains) {
                  return GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    children: ({}
                          ..addEntries(colors.entries.take(4))
                          ..addEntries(colors.entries.skip(4).take(4).toList().reversed)
                          ..addEntries(colors.entries.skip(8).take(4))
                          ..addEntries(colors.entries.skip(12).toList().reversed))
                        .entries
                        .map(color)
                        .toList(),
                  );
                },
              )
            ],
          ),
        ));
  }
}
