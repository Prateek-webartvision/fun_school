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
  static Future<List<CommunityDiscussionModel>> getDiscussionsPosts(
    String userId,
  ) async {
    Map<String, String> param = {};
    param['current_user_id'] = userId;

    return await _api
        .getApi(AppUrls.getCommunityDiscussionPost, params: param)
        .then((value) {
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
    String? hashTag,
    List<PlatformFile>? images,
  }) async {
    Map<String, dynamic> param = {};

    param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['topic'] = topic;
    param['text'] = subject;
    param['hashtag'] = hashTag;

    Map<String, List<File>> files = {};
    if (images != null && images.isNotEmpty) {
      files['images[]'] = images.map((e) => File(e.path!)).toList();
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

  //* filter by hash tag
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

  //* filter by User id
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

  //* get hash tags
  static Future<List<TrendingHashTags>> getTrendingHashTags(
    String userId,
  ) async {
    Map<String, String> param = {};
    param['current_user_id'] = userId;

    return await _api
        .getApi(AppUrls.getTrendingHashtags, params: param)
        .then((value) {
      List<TrendingHashTags> trendingHashtags = [];
      for (var element in value) {
        final tag = TrendingHashTags.fromJson(element);
        trendingHashtags.add(tag);
      }
      return trendingHashtags;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  //* like and dislike discussion
  static Future likeDislikeDiscussion({required String discussionId}) async {
    Map<String, String> params = {};
    params['discussion_id'] = discussionId;
    params['user_id'] = AppStorage.user.currentUser()!.userId!.toString();

    return await _api
        .getApi(AppUrls.discussionLikeDislike, params: params)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  //* discussion Comment
  static Future commentDiscussion({
    required String discussionId,
    String? comment,
    PlatformFile? image,
  }) async {
    Map<String, String> params = {};
    params['pub_id'] = discussionId;
    params['user_id'] = AppStorage.user.currentUser()!.userId!.toString();
    if (comment != null) {
      params['text'] = comment;
    }

    List<File> img = [];
    if (image != null) {
      img.add(File(image.path!));
    }

    final res = await _api.postWithFiles(AppUrls.discussionComment,
        params: params, files: {"images": img});

    if (res['code'] == 200) {
      log(res.toString());
    } else {
      throw res['message'];
    }
  }

  // * follow and un-follow
  static Future followUnFollow(String followingID) async {
    Map<String, String> param = {};
    param['follower_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['following_id'] = followingID;

    await _api.postApi(AppUrls.followUnFollow, params: param);
  }
}
