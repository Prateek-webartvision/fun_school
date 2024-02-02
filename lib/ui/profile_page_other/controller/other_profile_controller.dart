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
    state = ApiState.loading;
    _iniLoadProfile();
  }

  // load profile
  _iniLoadProfile() async {
    // CommunityDiscussionRepostory
    await OthersProfileRepository.getProfile(userId: userId.toString())
        .then((value) {
      data = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
  }

  // reload profile
  reLoadProfile() async {
    await _iniLoadProfile();
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
