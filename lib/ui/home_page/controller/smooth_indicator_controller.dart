import 'package:flutter/material.dart';

class SmoothIndicatorController extends ChangeNotifier {
  late int currentIndex;
  SmoothIndicatorController(this.currentIndex);

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
