import 'package:citycloud_school/models/community_discussion_model/community_discussion_model.dart';
import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

class OthersProfileRepository {
  static final _api = AppApi();

  static Future<OtherProfileModel> getProfile({required String userId}) async {
    return await _api.getApi(AppUrls.getOtherProfile,
        params: {"user_id": userId}).then((value) {
      final profile = OtherProfileModel.fromJson(value);
      return profile;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class OtherProfileModel {
  int? userId;
  String? username;
  String? email;
  String? about;
  String? userType;
  String? profileImage;
  String? posts;
  String? followers;
  String? following;
  String? regDate;
  String? status;
  List<FollowingModel>? followersProfiles;
  bool isFollowed = false;
  List<CommunityDiscussionModel>? discussions;

  OtherProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    about = json['about'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    posts = json['posts'];
    followers = json['followers'];
    following = json['following'];
    regDate = json['reg_date'];
    status = json['status'];
    if (json['followers_profiles'] != null) {
      List<FollowingModel> followers = [];
      for (var element in json['followers_profiles']) {
        final follow = FollowingModel.fromJson(element);
        if (follow.userId! == AppStorage.user.currentUser()!.userId) {
          isFollowed = true;
        }
        followers.add(follow);
      }
      followersProfiles = followers;
    }
    // discussion
    if (json['discussions'] != null) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in json['discussions']) {
        final dis = CommunityDiscussionModel.fromJson(element);
        discussions.add(dis);
      }
      this.discussions = discussions;
    }
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['user_id'] = userId;
    json['username'] = username;
    json['email'] = email;
    json['about'] = about;
    json['user_type'] = userType;
    json['profile_image'] = profileImage;
    json['posts'] = posts;
    json['followers'] = followers;
    json['following'] = following;
    json['reg_date'] = regDate;
    json['status'] = status;

    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class FollowingModel {
  int? userId;
  String? username;
  String? aboutUser;
  String? userProfileImage;
  String? userType;

  FollowingModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    aboutUser = json['About_user'];
    userProfileImage = json['user_profile_image'];
    userType = json['user_type'];
  }
}
