import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';

import '../../models/community_discussion_model/community_discussion_model.dart';

class CommunityDiscussionRepository {
  static final _api = AppApi();

  //* get all Discussion
  static Future<List<CommunityDiscussionModel>> getDiscussionsPosts() async {
    return await _api.getApi(AppUrls.getCommunityDiscussionPost).then((value) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionModel discussion =
            CommunityDiscussionModel.fromJson(element);
        discussions.add(discussion);
      }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  //* post timeLine discussion
  static Future<void> postTimeLineDiscussion({
    required String topic,
    required String subject,
    List<String>? hashTag,
    List<PlatformFile>? images,
  }) async {
    Map<String, dynamic> param = {};

    param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['topic'] = topic;
    param['text'] = subject;
    param['hashtag'] = hashTag?.join(" ");

    Map<String, List<File>> files = {};
    if (images != null && images.isNotEmpty) {
      files['images'] = images.map((e) => File(e.path!)).toList();
    }

    final res = await _api.postWithFiles(
      AppUrls.communityPostTimelines,
      params: param,
      body: null,
      files: files,
    );
    if (res['code'] == 200) {
      log(res['code'].toString());
    } else {
      throw res['message'].toString();
    }
  }

  // filter by hash tag
  static Future<List<CommunityDiscussionModel>> filterDiscussionByHashtag({
    required String tag,
  }) async {
    return await _api.getApi(AppUrls.getCommunityDiscussionPost,
        params: {"hashtag": tag}).then((value) {
      List<CommunityDiscussionModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionModel discussion =
            CommunityDiscussionModel.fromJson(element);
        discussions.add(discussion);
      }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // filter by User id
  static Future<List<CommunityDiscussionUserModel>> filterDiscussionByUser(
      {required String userId}) async {
    return await _api.getApi(AppUrls.getCommunityDiscussionPost,
        params: {"user_id": userId}).then((value) {
      List<CommunityDiscussionUserModel> discussions = [];
      for (var element in value) {
        final CommunityDiscussionUserModel discussion =
            CommunityDiscussionUserModel.fromJson(element);
        discussions.add(discussion);
      }
      return discussions;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // get hash tags
  static Future<List<TrendingHashTags>> getTandingHashTags() async {
    return await _api.getApi(AppUrls.getTrendingHashtags).then((value) {
      List<TrendingHashTags> tandingHashtags = [];
      for (var element in value) {
        final tag = TrendingHashTags.fromJson(element);
        tandingHashtags.add(tag);
      }
      return tandingHashtags;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // like and dislike discussion
  static Future likeDislikeDiscussion({required String discussionId}) async {
    Map<String, String> perams = {};
    perams['discussion_id'] = discussionId;
    perams['user_id'] = AppStorage.user.currentUser()!.userId!.toString();

    return await _api
        .getApi(AppUrls.discussionLikeDislike, params: perams)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // discussion Comment
  static Future commentDiscussion({
    required String discussionId,
    required String comment,
  }) async {
    Map<String, String> params = {};
    params['pub_id'] = discussionId;
    params['user_id'] = AppStorage.user.currentUser()!.userId!.toString();
    params['text'] = comment;

    final res = await _api.postApi(AppUrls.discussionComment, params: params);
    if (res['code'] == 200) {
      log(res.toString());
    } else {
      throw res['message'];
    }
  }
}
