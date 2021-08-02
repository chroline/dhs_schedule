import 'package:flutter/material.dart';

import '../../util/colors.dart';

class ColorPicker extends StatelessWidget {
  final Function(String) onTap;

  const ColorPicker({Key? key, required this.onTap}) : super(key: key);

  Widget color(MapEntry<dynamic, dynamic> k) => Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: k.value,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => onTap(k.key),
            splashColor: (k.value as MaterialColor).shade200,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constrains) => GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                shrinkWrap: true,
                children: ({}
                      ..addEntries(colors.entries.take(4))
                      ..addEntries(
                          colors.entries.skip(4).take(4).toList().reversed)
                      ..addEntries(colors.entries.skip(8).take(4))
                      ..addEntries(colors.entries.skip(12).toList().reversed))
                    .entries
                    .map(color)
                    .toList(),
              ),
            )
          ],
        ),
      ));
}
