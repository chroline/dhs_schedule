import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class AboutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutView();
}

class _AboutView extends State<AboutView> {
  AppBar get appBar => AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          'About the app',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.red.shade700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.red.shade700,
          ),
          onPressed: () => mainKey.currentState!.openDrawer(),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 54),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () =>
                          launch('https://forms.gle/W4N5rpjo2jArKbERA'),
                      icon: const Icon(Icons.speaker_notes),
                      label: const Text('PROVIDE FEEDBACK'),
                      style:
                          TextButton.styleFrom(primary: Colors.grey.shade900),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () =>
                          launch('https://projects.colegaw.in/dhs-schedule'),
                      icon: const Icon(Icons.code),
                      label: const Text('LEARN MORE ABOUT THIS APP'),
                      style:
                          TextButton.styleFrom(primary: Colors.grey.shade900),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  const Text(
                    '"Deerfield High School", "DHS", "Warriors", and the '
                    'Warriors logo are property of their respective owners.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
