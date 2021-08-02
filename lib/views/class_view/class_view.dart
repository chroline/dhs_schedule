import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../main.dart';
import '../../util/colors.dart';
import '../../util/ctrl/configuration.dart';
import '../../util/icons.dart';
import 'color_picker.dart';
import 'icon_picker.dart';

class ClassView extends StatefulWidget {
  final String id;

  const ClassView({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClassView();

  static void showClassView(String id) => showModalBottomSheet(
      context: mainKey.currentContext!,
      isScrollControlled: true,
      builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClassView(
                id: id,
              )
            ],
          ),
      elevation: 3);
}

class _ClassView extends State<ClassView> {
  final nameCtrl = TextEditingController();

  late MaterialColor color;
  late MapEntry<String, IconData> icon;

  @override
  void initState() {
    super.initState();
    final i = GetIt.I<Configuration>().periods[widget.id]!;
    color = colors[i.color]!;
    icon = MapEntry(i.icon, allIcons[i.icon]);
    nameCtrl.value = TextEditingValue(text: i.name);
  }

  Widget get appBar => Material(
        elevation: 3,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.id,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.palette),
                onPressed: _showColorPicker,
              )
            ],
          ),
        ),
      );

  Widget nameField(void Function() onSave) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: false,
            controller: nameCtrl,
            onEditingComplete: onSave,
            onTap: () {
              if (nameCtrl.value.text == widget.id) {
                nameCtrl.value = const TextEditingValue(text: '');
              }
            },
            keyboardType: TextInputType.text,
            maxLines: null,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
                labelText: 'Class Name',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 20),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                )),
            style: const TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
          ),
          const Text(
            'Enter the name of your class',
            style:
                TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
          )
        ],
      );

  Widget get iconSelector => InkWell(
        onTap: _showIconPicker,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Icon(
                    icon.value,
                    size: 24,
                    color: color,
                  ),
                ),
                Text(icon.key,
                    style: TextStyle(
                        fontSize: 24,
                        color: color,
                        fontWeight: FontWeight.w600))
              ],
            ),
            const Text(
              'Choose an Icon',
              style:
                  TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            color: Colors.grey.shade50,
            width: double.infinity,
            child: Column(
              children: [
                appBar,
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: nameField(_saveText),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: iconSelector,
                ),
              ],
            ),
          )
        ],
      );

  void _showColorPicker() {
    _saveText();
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: ColorPicker(
                onTap: (theColor) {
                  GetIt.I<Configuration>()
                      .updatePeriod(widget.id, color: colors[theColor]!);
                  setState(() => color = colors[theColor]!);
                  Navigator.pop(context);
                },
              ),
            ));
  }

  void _showIconPicker() {
    _saveText();
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: IconPicker(
                onTap: (k) {
                  GetIt.I<Configuration>().updatePeriod(widget.id, icon: k.key);
                  setState(() => icon = k as MapEntry<String, IconData>);
                  Navigator.pop(context);
                },
              ),
            ));
  }

  void _saveText() {
    GetIt.I<Configuration>().updatePeriod(widget.id, name: nameCtrl.value.text);
    FocusScope.of(context).unfocus();
  }
}
