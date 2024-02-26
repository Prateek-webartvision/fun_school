import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/community_discussion_model/community_discussion_model.dart';
import '../../../repo/profile_repo/others_profile.dart';
import '../../../style/assets.dart';

class OtherProfileController extends GetxController {
  late ApiState state;
  String? error;
  OtherProfileModel? data;
  final int userId;

  OtherProfileController(this.userId) {
    initProfile();
  }

  //* load profile
  initProfile() async {
    state = ApiState.loading;
    update();

    await _load();
    update();
  }

  // reload profile
  reLoadProfile() async {
    await _load();
  }

  setLikeDisLike({required CommunityDiscussionModel discussion}) {
    discussion.isLiked = !discussion.isLiked;
    if (discussion.isLiked) {
      discussion.likesCount = discussion.likesCount! + 1;
    } else {
      discussion.likesCount = discussion.likesCount! - 1;
    }
    update();
  }

  _load() async {
    // Community Discussion Repository
    try {
      final res =
          await OthersProfileRepository.getProfile(userId: userId.toString());
      data = res;
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }

    update();
  }
}

SvgPicture? getProfileBadges(String userType) {
  switch (userType) {
    case "Normal_Tutor":
      return SvgPicture.asset(AppAssets.svg.normalTutor);
    case "Certified_Tutor":
      return SvgPicture.asset(AppAssets.svg.normalTutor);
    case "Scholar":
      return SvgPicture.asset(AppAssets.svg.scholar);
    default:
      return null;
  }
}
