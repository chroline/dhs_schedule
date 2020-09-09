import 'package:dhs_schedule/util/views.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigationController extends ChangeNotifier {
  View view;

  static load() async {
    GetIt.I.registerSingleton<NavigationController>(NavigationController());
  }

  void update(View view) {
    this.view = view;
    notifyListeners();
  }
}
