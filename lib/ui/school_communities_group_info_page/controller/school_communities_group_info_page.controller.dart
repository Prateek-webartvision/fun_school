import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../network/data/app_storage.dart';
import '../../../repo/community/community_group_repo.dart';

class SchoolCommunitiesGroupInfoPageController extends GetxController {
  ApiState? state;
  String? error;
  CommunityGroupModel? groupInfo;

  final String groupID;

  SchoolCommunitiesGroupInfoPageController(this.groupID) {
    initLoad;
  }

  GroupMember? getMember(CommunityGroupModel? data) {
    final gg = data?.groupMembers?.where((element) =>
        element.memberId! == AppStorage.user.current!.userId!.toString());

    if (gg != null && gg.isNotEmpty) {
      return gg.first;
    } else {
      return null;
    }
  }

  Future<void> get initLoad async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> get reLoad async {
    _load();
  }

  _load() async {
    try {
      groupInfo = await CommunityGroupRepository.groupDetailsByID(groupID);
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }
}
