import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/community/community_group_repo.dart';

class CommunityGroupController extends GetxController {
  late ApiState state;
  String? error;
  List<CommunityGroupModel>? groups;

  CommunityGroupController() {
    initLoad();
  }

  // load Data
  Future _loadData() async {
    await CommunityGroupRepository.getGroups().then((value) {
      groups = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
  }

  // ini load
  initLoad() async {
    state = ApiState.loading;
    update();
    await _loadData();
  }

  // reload
  reLoad() async {
    await _loadData();
  }
}
