import 'package:dhs_schedule/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../util/colors.dart';
import '../../util/ctrl/configuration.dart';
import '../../util/icons.dart';
import 'color_picker.dart';
import 'icon_picker.dart';

class ClassView extends StatefulWidget {
  final String id;

  const ClassView({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClassView();

  static void showClassView(String id) => showModalBottomSheet(
      context: mainKey.currentContext,
      isScrollControlled: true,
      builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClassView(
                id: id,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
      elevation: 3);
}

class _ClassView extends State<ClassView> {
  final nameCtrl = TextEditingController();

  MaterialColor color;
  MapEntry<String, IconData> icon;

  Widget get appBar => Material(
        elevation: 3,
        color: color,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.id,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.palette),
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
                nameCtrl.value = TextEditingValue(text: "");
              }
            },
            keyboardType: TextInputType.text,
            maxLines: null,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                labelText: 'Class Name',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 20),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2),
                )),
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Text(
            "Enter the name of your class",
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
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
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
            Text(
              "Choose an Icon",
              style:
                  TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
            )
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    var i = GetIt.I<Configuration>().periods[widget.id];
    color = colors[i.color];
    icon = MapEntry(i.icon, allIcons[i.icon]);
    nameCtrl.value = TextEditingValue(text: i.name);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            color: Colors.grey.shade50,
            width: double.infinity,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar,
                Padding(
                  padding:
                      EdgeInsets.only(top: 48, bottom: 18, left: 24, right: 24),
                  child: nameField(_saveText),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18, bottom: 48, left: 24, right: 24),
                  child: iconSelector,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showColorPicker() {
    _saveText();
    showDialog(
        context: context,
        child: Dialog(
          child: ColorPicker(
            onTap: (theColor) {
              GetIt.I<Configuration>()
                  .updatePeriod(widget.id, color: colors[theColor]);
              setState(() => color = colors[theColor]);
              Navigator.pop(context);
            },
          ),
        ));
  }

  void _showIconPicker() {
    _saveText();
    showDialog(
        context: context,
        child: Dialog(
          child: IconPicker(
            onTap: (k) {
              GetIt.I<Configuration>().updatePeriod(widget.id, icon: k.key);
              setState(() => icon = k);
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
