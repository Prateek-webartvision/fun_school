import 'package:get/get.dart';

import '../../../network/data/app_storage.dart';
import 'school_communities_group_info_page.controller.dart';

class SheetController extends GetxController {
  bool showSafe = false;

  set changeSage(bool v) {
    showSafe = v;
    update();
  }

  bool canShowPopup({
    required GroupInfoPageController controller,
    String? currentMember,
  }) {
    final groupOwner = controller.groupInfo?.groupOwnerId;
    final currentUser = AppStorage.user.current?.userId?.toString();
    if (groupOwner == currentUser && groupOwner != currentMember) {
      return true;
    } else {
      return false;
    }
  }
}
