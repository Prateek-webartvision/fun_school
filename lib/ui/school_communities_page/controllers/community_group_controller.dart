import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../network/data/app_storage.dart';
import '../../../repo/community/community_group_repo.dart';

class CommunityGroupController extends GetxController {
  late ApiState state;
  String? error;
  List<CommunityGroupModel>? groups;

  CommunityGroupController() {
    initLoad();
  }

  CommunityGroupModel? getDataByID(String id) {
    if (groups != null) {
      final gg = groups!.where((element) => element.groupId == id);
      return gg.first;
    } else {
      return null;
    }
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

  // load Data
  Future _loadData() async {
    try {
      // final myGroups = await CommunityGroupRepository.myGroups;
      final myGroups = await CommunityGroupRepository.allOtherGroups;
      groups = myGroups;
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
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
