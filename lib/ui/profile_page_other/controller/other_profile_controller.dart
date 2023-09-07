import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

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
    await OthersProfileRepository.getProfile(userId: userId.toString()).then((value) {
      data = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
    // await CommunityDiscussionRepostory.filterDiscussionByUser(userId: userId.toString()).then((value) {
    //   print(value);
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
  }

  // reload profile
  reLoadProfil() async {
    await _iniLoadProfile();
  }
}

SvgPicture? getProfileBages(String userType) {
  // String normaluser = "Normal_User";
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
