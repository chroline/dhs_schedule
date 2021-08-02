import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../views.dart';

class NavigationController extends ChangeNotifier {
  View? view;

  void update(View view) {
    this.view = view;
    notifyListeners();
  }

  static void init() {
    GetIt.I.registerSingleton<NavigationController>(NavigationController());
  }
}
