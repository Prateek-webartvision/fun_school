import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/community_discussion_model/community_discussion_model.dart';
import '../../../repo/community/community_discussion_repo.dart';

class CommunityDiscussionController extends GetxController {
  late ApiState state;
  String? error;
  List<CommunityDiscussionModel>? _discussions;
  List<CommunityDiscussionModel>? discussions;
  List<TrendingHashTags>? trendingHashTags;
  String? selectedTag;

  CommunityDiscussionController() {
    initLoad();
  }

  set setSelectTag(String tag) {
    selectedTag = tag;
    // discussions = _filterDiscussion(_discussions!, byHashTag: selectedTag);
    _filter();
    update();
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

  _filter() async {
    state = ApiState.loading;
    update();
    await CommunityDiscussionRepository.filterDiscussionByHashtag(
            tag: selectedTag!)
        .then((value) {
      state = ApiState.success;
      discussions = value;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }

  Future<void> initLoad() async {
    state = ApiState.loading;
    update();
    await _loadData();
    discussions = _discussions;
    update();
  }

  Future<void> reload() async {
    selectedTag = null;
    await _loadData();
    discussions = _discussions;
    update();
  }

  _loadData() async {
    //
    await CommunityDiscussionRepository.getTandingHashTags().then((value) {
      trendingHashTags = value;
    }).onError((error, stackTrace) {
      this.error = error.toString();
    });
    //
    await CommunityDiscussionRepository.getDiscussionsPosts().then((value) {
      state = ApiState.success;
      _discussions = value;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }
}
