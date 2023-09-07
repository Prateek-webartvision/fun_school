// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/models/community_discussion_model/community_discussion_model.dart';
import 'package:citycloud_school/ui/school_communities_page/tabs/discourssion_tab/wigets/text_post_tile.dart';
import 'package:flutter/material.dart';

import '../../../repo/community/community_discussion_repo.dart';
import '../../../repo/profile_repo/others_profile.dart';
import '../../../uitls/app_utils.dart';

class PostTab extends StatelessWidget {
  const PostTab({
    super.key,
    required this.discussions,
    required this.profile,
  });
  final List<CommunityDiscussionModel> discussions;
  final OtherProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: discussions.length,
      itemBuilder: (context, index) {
        final item = discussions[index];
        return TextPostTile(
          profileUrl: profile.profileImage,
          userName: profile.username!,
          time: DateTime.fromMicrosecondsSinceEpoch(int.parse(item.time!) * 1000000).toString(),
          type: item.type!,
          userType: profile.userType!,
          isVerify: profile.userType == "Certified_Tutor",
          topic: item.topic,
          message: item.text,
          media: item.media,
          first2Likes: item.likes,
          likes: item.likesCount,
          replies: item.replysCount,
          onLikeClick: () {
            // call like api
            AppUtils.showloadingOverlay(() async {
              await CommunityDiscussionRepostory.likeDislikeDiscussion(discussionId: item.discussionId.toString());
            });
          },
        );
      },
      separatorBuilder: (_, __) => Divider(
        height: 0,
      ),
    );
  }
}
