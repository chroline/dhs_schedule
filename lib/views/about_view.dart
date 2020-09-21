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
        brightness: Brightness.light,
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
        child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Amet volutpat consequat mauris nunc. In eu mi bibendum neque egestas. Ridiculus mus mauris vitae ultricies leo integer malesuada nunc. Scelerisque mauris pellentesque pulvinar pellentesque habitant morbi. Bibendum at varius vel pharetra vel turpis nunc eget. At in tellus integer feugiat. Ornare arcu odio ut sem. Aliquet bibendum enim facilisis gravida neque convallis. Nisl pretium fusce id velit ut. Velit laoreet id donec ultrices tincidunt. Egestas integer eget aliquet nibh. Tristique magna sit amet purus gravida quis blandit turpis cursus. Vitae turpis massa sed elementum tempus egestas sed sed. Viverra nam libero justo laoreet sit. Nam at lectus urna duis convallis. Sed enim ut sem viverra aliquet eget sit amet tellus. Pulvinar mattis nunc sed blandit libero volutpat. Platea dictumst quisque sagittis purus sit amet."), // TODO: add content about the app
      ),
    );
  }
}
