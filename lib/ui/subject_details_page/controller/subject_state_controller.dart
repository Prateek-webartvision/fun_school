import 'package:flutter/material.dart';

import '../tab_pages/chapter_tab.dart';

class SubjectStateController extends ChangeNotifier {
  SubjectState state;
  SubjectStateController({required this.state});

  updateState(SubjectState state) {
    this.state = state;
    notifyListeners();
  }
}
