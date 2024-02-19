import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:get/get.dart';

class NavPageController extends GetxController {
  int currentIndex = 0;

  updatePage({required int index}) {
    if (currentIndex != index) {
      currentIndex = index;
      update();
      appRoutes.goNamed(getLocationName(index));
    }
  }

  getLocationName(int index) {
    switch (index) {
      case 0:
        return PagesName.homePage;
      case 1:
        return PagesName.studyPage;
      case 2:
        return PagesName.examPreparationPage;
      case 3:
        return PagesName.schoolCommunitiesPage;
      case 4:
        return PagesName.profileAndSettings;
    }
  }
}
