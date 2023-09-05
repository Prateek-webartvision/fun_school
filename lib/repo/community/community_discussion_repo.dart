import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

import '../../models/community_discussion_model/community_discussion_model.dart';

class CommunityDiscussionRepostory {
  static final _api = AppApi();

  // get all discustions
  static Future<List<CommunityDiscussionModel>> getDiscussionsPosts() async {
    return await _api.getApi(AppUrls.getCommunityDiscussionPost).then((value) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionModel discussion = CommunityDiscussionModel.fromJson(element);
        discussions.add(discussion);
      }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // filter by hash tag
  static Future<List<CommunityDiscussionModel>> filterDiscussionByHashtag({required String tag}) async {
    return await _api.getApi(AppUrls.getCommunityDiscussionPost, params: {"hashtag": tag}).then((value) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionModel discussion = CommunityDiscussionModel.fromJson(element);
        discussions.add(discussion);
      }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // get hash tags
  static Future<List<TrandingHashtags>> getTandingHashTags() async {
    return await _api.getApi(AppUrls.getTrendingHashtags).then((value) {
      List<TrandingHashtags> tandingHashtags = [];
      for (var element in value) {
        final tag = TrandingHashtags.fromJson(element);
        tandingHashtags.add(tag);
      }
      return tandingHashtags;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
