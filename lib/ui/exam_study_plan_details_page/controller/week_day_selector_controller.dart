import 'package:get/get.dart';

class WeekDaySelectorController extends GetxController {
  late int _i;
  WeekDaySelectorController({int initIndex = 0}) {
    _i = initIndex;
  }

  int get currentIndex => _i;
  set currentIndex(int i) {
    _i = i;
    update();
  }
}
