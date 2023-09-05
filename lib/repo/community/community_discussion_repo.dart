import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

import '../../models/community_discussion_model/community_discussion_model.dart';

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
