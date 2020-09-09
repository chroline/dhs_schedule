import 'package:dhs_schedule/main.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutView();
}

class _AboutView extends State<AboutView> {
  Widget get appBar => AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Text(
          "About the app",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.red.shade700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.red.shade700,
          ),
          onPressed: () => mainKey.currentState.openDrawer(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: appBar,
      body: Center(
        child: Text("hi"), // TODO: add content about the app
      ),
    );
  }
}
