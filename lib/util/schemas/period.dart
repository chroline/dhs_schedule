import 'package:flutter/material.dart';

class Period {
  final String id;
  final TimeOfDay start;
  final TimeOfDay end;

  Period({required this.id, required this.start, required this.end});
}
