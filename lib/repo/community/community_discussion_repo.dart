import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

class CommunityDiscussionRepostory {
  static final _api = AppApi();

  static Future<List<CommunityDiscussionModel>> getDiscussionsPosts() async {
    // print(AppStorage.user.currentUser()!.userid.toString());
    return await _api.getApi(AppUrls.getCommunityDiscussionPost).then((value) {
      // if (value != null) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionModel discussion = CommunityDiscussionModel.fromJson(element);
        discussions.add(discussion);
      }
      // }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class CommunityDiscussionModel {
  int? discussionId;
  int? userId;
  String? username;
  String? aboutUser;
  String? userProfileImage;
  String? userType;
  String? text;
  String? type;
  int? replysCount;
  int? repostsCount;
  int? likesCount;
  String? status;
  int? threadId;
  String? target;
  dynamic ogData;
  String? time;
  String? edited;

  CommunityDiscussionModel.fromJson(Map<String, dynamic> json) {
    discussionId = json['discussion_id'];
    userId = json["user_id"];
    username = json['username'];
    aboutUser = json['About_user'];
    userProfileImage = json['user_profile_image'];
    userType = json['user_type'];
    text = json['text'];
    type = json['type'];
    replysCount = json['replys_count'];
    repostsCount = json['reposts_count'];
    likesCount = json['likes_count'];
    status = json['status'];
    threadId = json['thread_id'];
    target = json['target'];
    ogData = json['og_data'];
    time = json['time'];
    edited = json['edited'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};

    json['discussion_id'] = discussionId;
    json["user_id"] = userId;
    json['username'] = username;
    json['About_user'] = aboutUser;
    json['user_profile_image'] = userProfileImage;
    json['user_type'] = userType;
    json['text'] = text;
    json['type'] = type;
    json['replys_count'] = replysCount;
    json['reposts_count'] = repostsCount;
    json['likes_count'] = likesCount;
    json['status'] = status;
    json['thread_id'] = threadId;
    json['target'] = target;
    json['og_data'] = ogData;
    json['time'] = time;
    json['edited'] = edited;

    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
