import 'package:flutter/material.dart';

class NoSchool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No school today!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          SizedBox(
            width: 100,
            child: Image.asset("assets/celebrate.png"),
          )
        ],
      ),
    );
  }
}
