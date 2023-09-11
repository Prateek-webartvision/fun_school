import 'package:get/get.dart';

class YearSelectorController extends GetxController {
  late int _seletedIndex;

  YearSelectorController({int? initIndex = 0}) {
    _seletedIndex = initIndex!;
  }

  int get index => _seletedIndex;
  changeIndex(int i) {
    _seletedIndex = i;
    update();
  }
}
