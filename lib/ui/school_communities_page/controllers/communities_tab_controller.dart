import 'package:get/get.dart';

class CommunitiesTabController extends GetxController {
  int currentIndex = 0;

  CommunitiesTabController({int? initIndex}) {
    if (initIndex != null) {
      currentIndex = initIndex;
    }
  }

  set index(int index) {
    currentIndex = index;
    update();
  }
}
