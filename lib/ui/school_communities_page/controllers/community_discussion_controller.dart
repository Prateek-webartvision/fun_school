import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/community/community_discussion_repo.dart';

class CommunityDiscussionController extends GetxController {
  late ApiState state;
  String? error;
  List<CommunityDiscussionModel>? discussions;

  CommunityDiscussionController() {
    iniLoad();
  }

  iniLoad() async {
    state = ApiState.loading;
    update();
    _loadData();
  }

  _loadData() async {
    await CommunityDiscussionRepostory.getDiscussionsPosts().then((value) {
      state = ApiState.success;
      discussions = value;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }

  Future<void> reload() async {
    await _loadData();
  }
}
