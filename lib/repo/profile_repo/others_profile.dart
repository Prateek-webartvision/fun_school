import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

class OthersProfileRepository {
  static final _api = AppApi();

  static Future<OtherProfileModel> getProfile({required String userId}) async {
    return await _api.getApi(AppUrls.getOtherProfile, params: {"user_id": userId}).then((value) {
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
