import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/community_discussion_model/community_discussion_model.dart';
import '../../../repo/community/community_discussion_repo.dart';

class CommunityDiscussionController extends GetxController {
  late ApiState state;
  String? error;
  List<CommunityDiscussionModel>? _discussions;
  List<CommunityDiscussionModel>? discussions;
  List<TrandingHashtags>? trendingHastags;
  String? selectedTag;

  CommunityDiscussionController() {
    iniLoad();
  }

  set setSelectTag(String tag) {
    selectedTag = tag;
    // discussions = _filterDiscussion(_discussions!, byHashTag: selectedTag);
    _filter();
    update();
  }

  _filter() async {
    state = ApiState.loading;
    update();
    await CommunityDiscussionRepostory.filterDiscussionByHashtag(tag: selectedTag!).then((value) {
      state = ApiState.success;
      discussions = value;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }

  iniLoad() async {
    state = ApiState.loading;
    update();
    await _loadData();
    discussions = _discussions;
    update();
  }

  _loadData() async {
    //
    await CommunityDiscussionRepostory.getTandingHashTags().then((value) {
      trendingHastags = value;
    }).onError((error, stackTrace) {
      this.error = error.toString();
    });
    //
    await CommunityDiscussionRepostory.getDiscussionsPosts().then((value) {
      state = ApiState.success;
      _discussions = value;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }

  Future<void> reload() async {
    selectedTag = null;
    await _loadData();
    discussions = _discussions;
    update();
  }
}

// sort discussions
// List<CommunityDiscussionModel> _filterDiscussion(List<CommunityDiscussionModel> data, {String? byHashTag}) {
//   List<CommunityDiscussionModel> tempData = [];

//   if (byHashTag != null) {
//     for (var element in data) {
//       bool isContain = false;
//       for (var e in element.hashtags!) {
//         if (e.hashtag == byHashTag) {
//           isContain = true;
//         }
//       }

//       if (isContain == true) {
//         tempData.add(element);
//       }
//     }
//   }

//   return tempData;
// }
