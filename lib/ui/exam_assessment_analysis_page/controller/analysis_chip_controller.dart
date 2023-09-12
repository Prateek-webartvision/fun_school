import 'package:get/get.dart';

class AnalysisChipController extends GetxController {
  late int _chipIndex;

  AnalysisChipController({int initIndex = 0}) {
    _chipIndex = initIndex;
  }

  int get currentIndex => _chipIndex;
  set currentIndex(int i) {
    _chipIndex = i;
    update();
  }
}
