import 'package:get/get.dart';

class CommunitiesTabController extends GetxController {
  int currentIndex = 0;

  CommunitiesTabController({int? initIntex}) {
    if (initIntex != null) {
      currentIndex = initIntex;
    }
  }

  set index(int index) {
    currentIndex = index;
    update();
  }
}
