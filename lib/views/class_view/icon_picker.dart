import 'package:flutter/material.dart';

import '../../util/icons.dart';

class IconPicker extends StatelessWidget {
  final Function(MapEntry<dynamic, dynamic>) onTap;

  const IconPicker({Key? key, required this.onTap}) : super(key: key);

  Widget icon(MapEntry<dynamic, dynamic> k) => InkWell(
        onTap: () => onTap(k),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2, right: 20, left: 20),
                  child: Icon(
                    k.value,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${k.key}',
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150, maxHeight: 450),
      child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 5),
          shrinkWrap: true,
          children: [
            for (var sublist in icons.entries.map(
                (entry) => [...entry.value.entries.map(icon), const Divider()]))
              ...sublist
          ]..removeLast()));
}
